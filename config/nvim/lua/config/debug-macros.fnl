;; Clojure example code of a debug macro
;; (do 
;;   (macro dbg [& forms] 
;;     `(do (apply prn (rest '~&form)) 
;;          (let [res# (do ~@forms)] (prn (symbol "=>") res#) res#)))
;;   
;;   
;;   (dbg (+ 1 2 3))))

(fn dbg [form] 
  (let [fennel#      (require :fennel)
        form-as-str# (fennel#.view form)]
    `(do (print ,form-as-str# "=>") ;
       (let [res# (do ,form)]
         (print "  " res#)
         res#))))

(comment
 (import-macros {: dbg : dbgn} :config.debug-macros)
 (dbg "aa"))
 


(comment 
  (local fennel (require :fennel))
  (print (fennel.view (fennel.list "aa" "bb")))
  (print "a" "b")

  (type type) ; "function"
  (type []) ; "table"
  (type {}) ; "table"
  (type 1) ; "number"


  (fennel.view {:aa :bb}) ; "{:aa \"bb\"}"

  (do
    (dbg (+ 1 2 3))
    (dbg (+ (dbg (/ 6 2)) 4))))
  

;; TODO
;; Priority
;; - [x] Handle sequences?
;;   - Need to check this but since sequences are just a table it might be ok as is with the current table handler
;;     - Confirmed to work!
;; - [ ] Handle locals/vars
;; - [ ] Handle func declarations
;;   - [ ] Check API for describing fennel syntax
;;   - [ ] ((fennel.syntax) "fn")
;;     - Should return {:function? true} which could be used to skip the function name (symbol?), binding/params and just traverse the body
;;     - Although this could be refering to whether a symbol is function... might need to do ((fennel.syntax "func-name")) instead
;; Nice to have
;; - [  ] print form, is list, is sym, type on same line for easier reading
;; - [ ] Tail call optimisation 
;; - [ ] Support depth number printing
;; - [ ] Support indentation based on depth

;; (do
  (fn dbgn [form params]

    ;; Requires so that the macro has its dependecies
    (fn protected-dbgn [] 
      (let [c (require :aniseed.core)
            mh (require :config.macro-helpers)
            form-meta {:filename (. form :filename)
                       :line (. form :line)
                       :bytestart (. form :bytestart)
                       :byteend (. form :byteend)}
            fennel (mh.protected-require-fennel form-meta)
            ;; Need to create a symbol for `print` so that print isn't evaluated when it's 
            default-params {:print-fn (fennel.sym :print) :debug? false}
            merged-params (c.merge default-params params)

            dbg-prn (fn [...] 
                      (when merged-params.debug? 
                        (print "MACRO-DBG " ...)))

            {:debug? debug? :print-fn print-fn} merged-params] 


        (fn dbg [form view-of-form] 
          ;; `view-of-form` can be used to provide a string representation of the original form
          (let [;; Get string representation of form before eval
                form-as-str# (if view-of-form 
                               view-of-form 
                               (view form))

                ;; "..." to indicate there may be nesting since it's a list
                ;; "=>" to indicate the final result
                ;; This needs some work... perhaps check for nested lists and symbols. If there are none, don't even print the first line
                first-line-suffix#    (if (list? form)
                                        "..."
                                        " =>")

                ;; If the form is a list, it can potentially have a lot of nested values which will have been expanded out. This can make it hard to tell what the final eval is for. So if it's a list, re-print the view of the form to provide context
                res-prefix# (if (list? form)
                              (.. form-as-str# " =>")
                              "  ")]

            ;; Produce the dbg'd form here
            `(do 
               ;; Example:
               ;; form = (+ 1 2)
               ;;
               ;; "(+ 1 2) ..."
               (,print-fn ,form-as-str# ,first-line-suffix#) 
               (let [res# (do ,form)
                     mh# (require :config.macro-helpers)
                     fennel# (mh#.protected-require-fennel)]
                 ;; Printing view of result in all cases, but I think it only really needs to be done for tables
                 ;; "(+ 1 2) => 3"
                 (,print-fn ,res-prefix# (fennel#.view res#))
                 ;; Return the evaluated result
                 res#))))

        (fn get-dbg-form [form]
          ;; Create deps with the idea that it can be passed into macro-helpers so it can use the params, print-fn, and this fn
          (local deps {:params merged-params 
                       :dbg-prn dbg-prn 
                       :get-dbg-form get-dbg-form})

          (dbg-prn "Form: " (view form))
          (dbg-prn "Type: " (type form))

          (if (not (-> form list?))
            (if (sym? form)
              ;; You don't want your symbol accidentally treated as a table
              (do 
                (dbg-prn "is symbol")
                (dbg form))

              (match (type form)
                ;; No need for extra printing for primitives at compile time
                :number form
                :string form
                ;; Tables that are neither lists nor sybols should have their keys and values replaced with dbg-forms
                :table (let [view-of-table (view form)
                             dbg-table (collect [k v (pairs form)]
                                         ;;      new key          new value
                                         (values (get-dbg-form k) (get-dbg-form v)))] 
                         (dbg dbg-table view-of-table))

                _ (dbg form)))

            ;; list
            (let [[operator & operands] form
                  view-of-form (view form)
                  syntax-tbl (mh.get-syntax-tbl operator)
                  ;; nil safe table lookup because functions defined in functions will no appear in the syntax table (might be possible but not sure how yet)
                  is-binding-form (?. syntax-tbl :binding-form?)
                  is-define (?. syntax-tbl :define?) ;; define is a local or fn
                  syn (fennel.syntax)]
              (dbg-prn "is list")
              (dbg-prn "syntax-tbl" (view syntax-tbl))

              (when is-define 
                (let [first-param-of-define (. operands 1)]
                  (dbg-prn "is-define, " 
                           "fn name: " first-param-of-define  ;; get fn name
                           "fn type: " (type first-param-of-define)
                           "fn symbol: " (sym? first-param-of-define) ;; Is a symbol if the value is returned
                           "vim.inspect: " (vim.inspect first-param-of-define)
                           "Syntax tbl for fn: " (view (mh.get-syntax-tbl (. operands 1)))) 
                  ;; (dbg-prn (view syn))
                  ))

              (dbg-prn "is defn" (= operator (fennel.sym :defn)))
              (dbg-prn "operands: " (view operands))
              (dbg-prn "is-binding-form: " is-binding-form)

              (match syntax-tbl

                ;; e.g. let
                {:binding-form? binding-form?}
                (let [[bindings & body] operands]
                  (dbg-prn "bindings: " (view bindings))
                  (dbg-prn "body: " (view body))
                  ;; Reconstruct the form 
                  (dbg (list operator bindings (unpack (c.map get-dbg-form body))) view-of-form))

                ;; setting globals/variables/locals
                (where {:special? true} (mh.is-set operator))
                (do 
                  (dbg-prn "special - set")
                  (mh.get-dbg-set operator operands deps))

                ;; e.g. function definitions
                ;; - (fn fn-name [] (...) ...)
                ;; - (fn [] (...) ...) 
                ;; - also should handle such as (defn fn-name [] (...) ...)
                ;;   - It appears that defn does not get included in the syntax tbl, perhaps because it's not part of fennel core; It's part of aniseed
                ;; - def?
                ;; - lambda?
                {:define? define?}
                (mh.get-dbg-define operator operands deps)

                ;; e.g. -> 
                ;; just dbg the form, do not replace the inner forms as that will interfere with the macro itself
                ;; Consider inserting `dbg` between all inner forms??
                {:macro? macro?}
                (dbg form)

                _ 
                (match (tostring operator)
                  ;; specific operators that don't get included in syntax-tbl
                  :defn- 
                  (do 
                    (dbg-prn "is aniseed defn-")
                    (mh.get-dbg-define operator operands deps))

                  :defn 
                  (do 
                    (dbg-prn "is aniseed defn")
                    (mh.get-dbg-define operator operands deps))

                  ;; other/default e.g. (+ a b c)
                  _ 
                  (dbg (list operator (unpack (c.map get-dbg-form operands))) view-of-form)))
              )))

        (get-dbg-form form)))

        (let [(ok? val-or-err) (pcall protected-dbgn)]
          (if ok? 
            val-or-err 
            (do (print "DBGN error:\n" val-or-err)
              form)))
        )
  
   
   ;; (dbgn
   ;;   (let [new-val (+ aa 1)]
   ;;     (global aa 1)
   ;;     (set aa new-val)) {:debug? true})

   ;; (dbgn (do 
   ;;         (global dd (- 3 1))
   ;;         (var cc 1)
   ;;         (set cc (+ cc 2))
   ;;         dd) {:debug? true})
  
  ;; (dbgn (set _G.bb {:bb (+ 1 2)}) {:debug? true})

  ;; )

(comment 

  ;; Example of multiple matches
  (match {:define? true :special? false}
    (where (or {:special? true} {:define? true}) false ) :YES
    _ :NO)

  (match {:special? true}
    (where {:special? true} true) :YES
    _ :NO) ; "YES"

  (match {:special? true}
    (where {:special? true} false) :YES
    _ :NO) ; "NO"

  ;; Moved some tests here so that less code is eval'd

  ;; (local c (require :aniseed.core))

;; (tostring (fennel.sym :aa))
;; (c.merge {:aa "aa"} {:bb "bb"})

  (dbgn (let [aa (-> 1 (+ 2))]
          (local bb {:bb-field 4})
          (+ bb.bb-field
             (-> aa (+ 3))))
        {:debug? true
         ;; :print-fn (fn [...] (print "DBG: " ...))
         })

  ;;---

  ;; (dbgn [1 2 3 (+ 2 2)])

  ;; (local a 1)
  ;; (dbgn (+ 1 a))

  ;; (dbgn (fn test-fn [a b]
  ;;         (let [c 3
  ;;               d (fn [] (+ 1 2 ))]
  ;;           (+ a b c (d)))))
  ;; (test-fn 1 2)

  ;; (dbgn (+ 1 2 (let [a 1 b 4] (+ a (/ b 1)))))
  ;; (dbgn { (.. "aa" "bb") (let [a 5] (+ 3 4 a (- 4 3)))})

  ;; (dbgn (defn- aaa [] (+ 1 2 3)) {:debug? true})
  ;; (aaa)

  ;; (dbgn (defn bbb [] (+ 2 3 4)) {:debug? true})
  ;; (bbb)
  
  )
  


(comment 
  (. [:a :b] 1)
  
  (do 
    (macro get-compile-type [form]
      (sym? form))
    
    (local a 1)

    (get-compile-type a)))

    ;; (get-compile-type 1)
    
    

;; Lua-api - https://fennel-lang.org/api
;; - AST 
;;   - Syntax
;; Reference - https://fennel-lang.org/reference#eval-compiler
;; Macros - https://fennel-lang.org/macros#using-functions-from-a-module
             


;; (fn get-syntax-tbl [operator]
;;   (let [fennel#      (require :fennel)
;;         syn#         (fennel#.syntax)
;;         operator-str (view operator)]
;;     (. syn# operator-str)))



(comment 
  (do 

    (macro prn-syntax [form]
      (when (-> form list?) 
        (let [[operator & operands] form
              mh                    (require :config.macro-helpers)
              syn-tbl               (mh.get-syntax-tbl operator)]
          (print (view operator) " - " (view syn-tbl))
          syn-tbl)))

    (prn-syntax (let [a "111"] (+ 1 2)))

    (prn-syntax (+ 1 2)))

  (do

    (macro prn-list-props [form]
      (when (-> form list?)
        (print "Line: " (. form :line))
        ; Check if filename is emitted when macro is used into another file (since macro files don't really have a lua equivalent)
        (print "Filename:" (. form :filename)) 
        (print "Bytestart: " (. form :bytestart))
        (print "Byteend " (. form :byteend))))


    (prn-list-props (+ 1 2))))
  
  
(comment
  (def t {:aa "aa" :bb {:things-in-b [:b :bb :bbb]}})

  (fennel.view t) ; "{:aa \"aa\" :bb {:things-in-b [\"b\" \"bb\" \"bbb\"]}}"

  (fennel.view (unpack ["a"])) ; nil
; "\"a\""

  (fennel.view ["a"]) ; "[\"a\"]"

  (print (fennel.view t))
  (vim.inspect t)
; "{
;   aa = \"aa\",
;   bb = {
;     [\"things-in-b\"] = { \"b\", \"bb\", \"bbb\" }
;   }
; }"
  (print (vim.inspect t))) ; nil

{:dbg dbg
 :dbgn dbgn}


