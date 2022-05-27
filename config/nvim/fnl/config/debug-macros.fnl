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
    
    (macro dbgn [form]
      (let [c# (require :aniseed.core)] 
        (fn print-form-elem [form]
          (print (view form) "=>")
          (match form
            (where f (-> f list?)) 
            (let [[head & tail] f]
              (print "IS LIST")
              (print "tail: " (view tail))
              (list head (unpack (c#.map print-form-elem tail))))

            (where f (= (type f) "function")) 
            (do 
              (print "IS FUNCTION")
              f)
              

            (where f (= (type f) "number")) 
            (do 
              (print "IS NUMBER")
              f)

            (where f (= (type f) "table")) 
            (do 
              (print "IS TABLE")
              f)

            (where f (sym? f)) 
            (do 
              (print "IS SYM")
              f)

            _ (print "primitive?")))

        (print-form-elem form)))
      

    (local x 42)
    (dbgn (+ 1 x (- 2 1)))))

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



