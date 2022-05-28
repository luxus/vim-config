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
  

;; Lua-api - https://fennel-lang.org/api
;; - AST 
;;   - Syntax
;; Reference - https://fennel-lang.org/reference#eval-compiler
;; Macros - https://fennel-lang.org/macros#using-functions-from-a-module
(comment 
  
  (match [1 2 3]
    (where [a b c] (= a 1)) (.. "this" "-" "matched")
    (where [a b c] (= a 2)) :no-match) 
  
  (do

    ;; (import-macros {: dbgn} :config.debug-macros)
    
    (macro dbgn [form]
      (let [c (require :aniseed.core)
            mh (require :config.macro-helpers)] 

        (fn dbg [form view-of-form] 
          (let [form-as-str# (if view-of-form 
                               view-of-form 
                               (view form))

                first-line-suffix#    (if (list? form)
                                       "..."
                                       " =>")
                               
                res-prefix# (if (list? form)
                              (.. form-as-str# " =>")
                              "  ")
                ]

            `(do (print ,form-as-str# ,first-line-suffix#) ;
               (let [res# (do ,form)
                     fennel# (require :fennel)]
                 ;; Printing view of result in all cases, but I think it only really needs to be done for tables
                 (print ,res-prefix# (fennel#.view res#))
                 res#))))

        (fn get-dbg-form [form]
          (print "form: " (view form))
          (if (not (-> form list?))

            (do 
              (print "Type: " (type form))
              (if (= (type form) "number")
                form ;; Don't need to print the number a second time
                (dbg form)))

            (let [[head & tail] form
                  view-of-form (view form)
                  is-binding-form (-> head 
                                      (mh.get-syntax-tbl)
                                      (. :binding-form?))]
              (print "Type: list")
              (print "tail: " (view tail))
              (print "is-binding-form" is-binding-form)
              (if is-binding-form
                (let [[bindings & body] tail]
                  (print "bindings: " (view bindings))
                  (print "body: " (view body))
                  (dbg (list head bindings (unpack (c.map get-dbg-form body))) view-of-form))

                (dbg (list head (unpack (c.map get-dbg-form tail))) view-of-form)))))

        (get-dbg-form form)))

    (local x 42)
    (local y 2)
    (dbgn (+ 1 x 
             (let [a 1] (+ 1 a))))
    
    (dbgn (. {:aa "aaa"} :aa))))
             


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



