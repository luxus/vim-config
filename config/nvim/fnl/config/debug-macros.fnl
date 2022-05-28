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
        (fn dbg [form view-of-form] 
          (let [form-as-str# (if view-of-form 
                               view-of-form 
                               (view form))
                res-prefix# (if (list? form)
                              (.. form-as-str# " =>")
                              "  ")]
                             
            `(do (print ,form-as-str# "=>") ;
               (let [res# (do ,form)]
                 (print ,res-prefix# res#)
                 res#))))

        (fn print-form-elem [form]
          (print (view form) "=>")
          (if (not (-> form list?))
            
            (do 
              (print "Type: " (type form))
              (if (= (type form) "number")
                form 
                (dbg form)))
            
            (let [[head & tail] form
                  view-of-form (view form)]
              (print "Type: list")
              (print "tail: " (view tail))
              (dbg (list head (unpack (c#.map print-form-elem tail))) view-of-form))))

        (print-form-elem form)))
      

    (local x 42)
    (local y 2)
    (dbgn (+ 1 x (- 2 (/ 6 y))))))

(comment 
  (do 
    
    (macro prn-syntax [form]
      (local fennel (require :fennel))
      (local syn (fennel.syntax))
      (when (-> form list?) 
        (let [[head & tail] form
              head-as-str (view head)
              syn-tbl (. syn head-as-str)]
          (print (view head))
          (print (view syn-tbl))
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

{:dbg dbg}



