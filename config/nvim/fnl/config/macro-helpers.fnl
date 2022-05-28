(module config.macro-helpers)

(defn get-syntax-tbl [operator]
    (let [fennel       (require :fennel)
          syn          (fennel.syntax)
          operator-str (fennel.view operator)]
        (. syn operator-str)))
