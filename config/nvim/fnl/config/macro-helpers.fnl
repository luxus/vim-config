(module config.macro-helpers)

(defn get-syntax-tbl [operator]
    (let [fennel       (require :fennel)
          syn          (fennel.syntax)
          operator-str (fennel.view operator)]
        (. syn operator-str)))

;; TODO 
;; Split into function for handling function definitions and one for variable definitions
(defn get-dbg-define [operator operands {: dbg-prn : get-dbg-form}]
  ;; Debug the operands, skipping the fn name and bindings
  (let [c (require :aniseed.core)
        f (require :fennel)
        ;; This is what should be done for fns, not def, local, global, set
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

(defn protected-require-fennel [form-meta]
  (local af (require :aniseed.fennel))
  (let [(ok? val-or-err) (pcall #(require :fennel))]
    (if ok?
      val-or-err
      (let [{: filename : line : bytestart} (or form-meta {})]
       (print "config.macro-helpers.protected-require-fennel: Forcing fennel require with aniseed.fennel.impl" 
                 (when (and filename line)
                   (.. " @ " filename " " line)))
        (af.impl)))))

(comment

 (let [{: a} nil]
   (print a)) ; attempt to index local '_let_6_' (a nil value)

 (let [all nil]
   (print (?. all :a))) ; nil

 (let [{: a} (or nil {})]
   (print a)) ; nil
 )
