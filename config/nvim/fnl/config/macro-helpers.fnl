(module config.macro-helpers)

(defn get-syntax-tbl [operator]
    (let [fennel       (require :fennel)
          syn          (fennel.syntax)
          operator-str (fennel.view operator)]
        (. syn operator-str)))

(defn get-dbg-define [operator operands get-dbg-form]
  ;; Debug the operands, skipping the fn name and bindings
  (let [t (-> (c.reduce 
                (fn [{: res : seen-seq &as acc} x]
                  (dbg-prn :acc (view acc))
                  (dbg-prn :x (view x))
                  ;; Only dbg the form if the bindings have been seen
                  (table.insert res (if seen-seq (get-dbg-form x) x))
                  {:res res
                   :seen-seq (or seen-seq (sequence? x))})
                {:res [] :seen-seq false}
                operands)
              (. :res))]

    ;; Don't debug the fn, wrapping it in `dos` will result in it not actually being evaluated and thus not existing and thus not possible to call... I don't really understand exactly why yet
    (list operator (unpack t))))
