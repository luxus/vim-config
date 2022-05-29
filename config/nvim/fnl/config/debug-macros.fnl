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
  
(do 
 
  (macro dbgn [form]
    ;; Requires so that the macro has its dependecies
    (let [c (require :aniseed.core)
          mh (require :config.macro-helpers)] 

      (fn dbg [form view-of-form] 
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
             (print ,form-as-str# ,first-line-suffix#) 
             (let [res# (do ,form)
                   fennel# (require :fennel)]
               ;; Printing view of result in all cases, but I think it only really needs to be done for tables
               ;; "(+ 1 2) => 3"
               (print ,res-prefix# (fennel#.view res#))
               ;; Return the evaluated result
               res#))))

      (fn get-dbg-form [form]
        (print "form: " (view form))
        (print "Type: " (type form))

        (if (not (-> form list?))
          (if (sym? form)
            ;; You don't want your symbol accidentally treated as a table
            (dbg form)

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

          (let [[operator & operands] form
                view-of-form (view form)
                is-binding-form (-> operator 
                                    (mh.get-syntax-tbl)
                                    (. :binding-form?))]
            (print "operands: " (view operands))
            (print "is-binding-form: " is-binding-form)
            (if is-binding-form 
              ;; Traversing bindings is its own problem... just deal with the body
              (let [[bindings & body] operands]
                (print "bindings: " (view bindings))
                (print "body: " (view body))
                ;; Reconstruct the form 
                (dbg (list operator bindings (unpack (c.map get-dbg-form body))) view-of-form))
              ;; Reconstruct the form
              (dbg (list operator (unpack (c.map get-dbg-form operands))) view-of-form)))))

      (get-dbg-form form)))
  
  ;; (local a 1)
  ;; (dbgn (+ 1 a))
  (dbgn (+ 1 2 (let [a 1] (+ a (/ 3 1)))))
  ;; (dbgn { (.. "aa" "bb") (let [a 5] (+ 3 4 a (- 4 3)))})
  
  )


(comment 
  
  
  (do 
    (macro get-compile-type [form]
      (sym? form))
    
    (local a 1)

    (get-compile-type a)

    ;; (get-compile-type 1)
    
    ))

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



