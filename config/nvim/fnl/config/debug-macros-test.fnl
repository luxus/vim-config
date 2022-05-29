(module config.debug-macros-test
    {require-macros [config.debug-macros]})

(comment  
    (do
        (import-macros {: dbg : dbgn} :config.debug-macros)
        (dbg (+ 1 2 3))
        (dbgn [1 2 3 (+ 2 2)]))
        ;; (dbgn (+ 1 2 3 (- 1 2)))
        


  (let [syntax (fennel.syntax)]
    (. syntax "vim")))

(comment 

    ;; Can use collect to iterate through table, recurse through values, and rebuild table with debug'd forms

    (collect [k v (pairs {:apple "red" :orange "orange" :lemon "yellow"})]
        (if (not= k "yellow")
            (values (.. "color-" v) k))) ; {:color-orange "orange" :color-red "apple" :color-yellow "lemon"}

    (collect [k v (pairs ["a" "b" "c" "d"])]
        (if (not= k "yellow")
            (values (.. "color-" v) k)))) ; {:color-a 1 :color-b 2 :color-c 3 :color-d 4}
    

(comment 
  
  (match [1 2 3]
    (where [a b c] (= a 1)) (.. "this" "-" "matched")
    (where [a b c] (= a 2)) :no-match) 
  
  (do

    ;; (import-macros {: dbgn} :config.debug-macros)
    
    (local x 42)
    (local y 2)
    (dbgn (+ 1 x 
             (let [a 1] (+ 1 a))))
    
    (dbgn (. {:aa "aaa"} :aa))))
