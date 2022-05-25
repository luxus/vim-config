;; Clojure example code of a debug macro
;; (do 
;;   (macro dbg [& forms] 
;;     `(do (apply prn (rest '~&form)) 
;;          (let [res# (do ~@forms)] (prn (symbol "=>") res#) res#)))
;;   
;;   
;;   (dbg (+ 1 2 3))))

(fn dbg [form] 
  (let [form-as-str# (view form)]
    `(do (print ,form-as-str# "=>") ;
       (let [res# (do ,form)]
         (print "  " res#)
         res#))))


(comment 
  (print (fennel.view (fennel.list "aa" "bb")))
  (print "a" "b")

  (type type) ; "function"
  (type []) ; "table"
  (type {}) ; "table"
  (type 1) ; "number"

  (do
    (dbg (+ 1 2 3))
    (dbg (+ (dbg (/ 6 2)) 4))))
  

;; (fn get-dbg-form [form]
;;   (list))




(comment 
  
  (match [1 2 3]
    (where [a b c] (= a 1)) (.. "this" "-" "matched")
    (where [a b c] (= a 2)) :no-match) 
  
  (do

    (local fennel (require :fennel))
    (local c (require :aniseed.core))

    (macro dbgn [form]
      (fn print-form-elem [form]
        (match form
          (where f (-> f list?)) (let [[head & tail] f]
                                      (print "IS LIST")
                                      (print "tail: " (view tail)))

          (where f (= (type f) "function")) (print "IS FUNCTION")
          (where f (= (type f) "number")) (print "IS NUMBER")
          (where f (= (type f) "table")) (print "IS TABLE")
          (where f (sym? f)) (print "IS SYM")
          _ (print "primitive?")))

      (print (view form))
      (print-form-elem form))
      

    (dbgn (+ 1 2 3))))

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

{:dbg dbg}



