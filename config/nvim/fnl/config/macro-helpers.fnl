(module config.macro-helpers)

(defn get-syntax-tbl [operator]
    (let [fennel       (require :fennel)
          syn          (fennel.syntax)
          operator-str (fennel.view operator)]
        (. syn operator-str)))

(defn get-dbg-define [operator operands {: dbg-prn : get-dbg-form}]
  ;; Debug the operands, skipping the fn name and bindings
  (let [c (require :aniseed.core)
        f (require :fennel)
        t (-> (c.reduce 
                (fn [{: res : seen-seq &as acc} x]
                  ;; Only dbg the form if the bindings have been seen
                  ;; these prints don't work because we don't have the print fn defined in here
                  (dbg-prn :acc (f.view acc))
                  (dbg-prn :x (f.view x))
                  (table.insert res (if seen-seq (get-dbg-form x) x))
                  {:res res
                   :seen-seq (or seen-seq (f.sequence? x))})
                {:res [] :seen-seq false}
                operands)
              (. :res))]

    ;; Don't debug the fn, wrapping it in `dos` will result in it not actually being evaluated and thus not existing and thus not possible to call... I don't really understand exactly why yet
    (f.list operator (unpack t))))

(defn protected-require-fennel []
  (local af (require :aniseed.fennel))
  (let [(ok? val-or-err) (pcall #(require :fennel))]
    (if ok?
      val-or-err
      (do (print "config.macro-helpers.protected-require-fennel: Forcing fennel require with aniseed.fennel.impl")
        (af.impl)))))

