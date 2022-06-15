(module config.plugin.conjure-python
  {autoload {a conjure.aniseed.core
             extract conjure.extract
             str conjure.aniseed.string
             nvim conjure.aniseed.nvim
             stdio conjure.remote.stdio
             config conjure.config
             text conjure.text
             mapping conjure.mapping
             client conjure.client
             log conjure.log
             ts conjure.tree-sitter
             ts_util nvim-treesitter.ts_utils
             f fennel}
   require-macros [conjure.macros
                   config.debug-macros]})

(comment 
  vim.g.conjure#filetype#clojure ; "conjure.client.clojure.nrepl"
  vim.g.conjure#filetypes ; ["clojure" "fennel" "janet" "hy" "racket" "scheme" "lua" "lisp"]
  (set vim.g.conjure#debug false)
  (dbgn {:a "aa"})
  )

(set vim.g.conjure#filetype#python :config.plugin.conjure-python) 
(set vim.g.conjure#filetypes [:clojure :fennel :janet :hy :racket :scheme :lua :lisp :python])
(set vim.g.conjure#debug true)

(config.merge
  {:client
   {:python
    {:stdio
     {:mapping {:start "cs"
                :stop "cS"
                :interrupt "ei"}
      ;; :command "python -m IPython"
      ;; https://stackoverflow.com/questions/55980470/how-to-print-output-of-an-interactive-child-process-from-parent-process
      :command "python -u -i -q"
      :prompt_pattern ">>> "}}}}
  {:overwrite? true})

(def- cfg (config.get-in-fn [:client :python :stdio]))

(defonce- state (client.new-state #(do {:repl nil})))


(defn send-to-repl [code] 
  (with-repl-or-warn 
    (fn [repl] 
      (-> (prep-code-2 code) 
          (repl.send (fn [msg]
                       (log.dbg "msg" msg)))))))

(local test-fn-str-1 
"
def bb():
    def inner_cc():
        print('inside cc3')
  
    inner_cc()

    print('inside bb3')

    return 'RESULT OF BB()'
"
)



(local test-fn-str-2 
"def cc():
    print('inside cc 1')

    print('inside cc 2')
    return 'cc'"
)

(comment 

  (prep-code-2 test-fn-str-1)

  (do
   (stop)
   (start))

  (log.dbg "msg" "frog" "egg")

  (do 
    (send-to-repl "print('hi')"))

  (do 
    "... ... ... ..." ;; is due to indentation
    (send-to-repl test-fn-str-1)
    )

  (do 
    (send-to-repl test-fn-str-2)
    )

  (do 
    (send-to-repl "cc()")
    )

  (do 
    (send-to-repl "(1 + 2 + 3)"))

  )




(def buf-suffix ".py")
(def comment-prefix "# ")
(do 
  (defn python-node? [node extra-pairs]
    (print "python node: \n" (ts.node->str node))
    (print "sexpr:" (node:sexpr))
    true)
  (def form-node? python-node?))

(defn- with-repl-or-warn [f opts]
  "If a REPL is active, call `f`, else display a warning"
  (let [repl (state :repl)]
    (if repl
      (f repl)
      (log.append [(.. comment-prefix "No REPL running")
                   (.. comment-prefix
                       "Start REPL with "
                       (config.get-in [:mapping :prefix])
                       (cfg [:mapping :start]))]))))

(defn- display-result [msg]
  (let [prefix (.. comment-prefix (if msg.err "(err)" "(out)") " ")]
    (->> (str.split (or msg.err msg.out) "\n")
         (a.filter #(~= "" $1))
         (a.map #(.. prefix $1))
         log.append)))

(defn replace-blank-lines [str-in]
  (->> (str.split str-in "\n")
       (a.filter #(not (str.blank? $1)))
       (str.join "\n")))

(comment
 (replace-blank-lines test-fn-str-1)
 )

(defn prep-code-2 [code] 
  ;; Need to handle blank lines in multiline blocks of code, e.g a func definition
  ;;
  ;; This is ok:
  ;; def aa():
  ;;     print("aa")
  ;;     print("aa again!")
  ;;
  ;; This is not:
  ;;
  ;; def aa():
  ;;     print("aa")
  ;; 
  ;;     print("aa again!")
  ;;
  ;; Need to make sure the blank line between the two print statements actually has the correct indentation as the line previous to and before it

  (let [fmt-code (replace-blank-lines code)
        ;; fmt-code (string.gsub code "\n\n+" "\n")
        [first & rest] (str.split fmt-code " ")]
    (if (= first "def")
      (.. fmt-code "\n\n")
      (.. fmt-code "\n"))))


(do
 
  (prep-code-2 "def funcname():")
  (prep-code-2 "(1 + 2)")
 )

(defn- prep-code [s]
  (.. s "\n"))

(defn eval-str [opts]
  ;; (local fennel (require :fennel))
  (print "python: evaluating - " (f.view opts))
  (var last-value nil)
  (with-repl-or-warn
    (fn [repl]
      (repl.send
        (prep-code-2 opts.code)
        (fn [msg]
          (log.dbg "msg" msg)
          ; (let [msgs (a.filter #(not (= "" $1)) (str.split (or msg.err msg.out) "\n"))])
          (let [msgs (->> (str.split (or msg.err msg.out) "\n")
                          (a.filter #(not (= "" $1))))]
                ; prefix (.. comment-prefix (if msg.err "(err)" "(out)") " ")]
            (set last-value (or (a.last msgs) last-value))
            ; (log.append (a.map #(.. prefix $1) msgs))
            (display-result msg)
            (when msg.done?
              ; (log.append [(.. comment-prefix "Finished")])
              (log.append [""])
              (when opts.on-result
                (opts.on-result last-value)))))))))

(defn eval-file [opts]
  (log.append [(.. comment-prefix "Not implemented")]))

;; (defn doc-str [opts]
;;   (let [obj (when (= "." (string.sub opts.code 1 1))
;;               (extract.prompt "Specify object or module: "))
;;         obj (.. (or obj "") opts.code)
;;         code (.. "(if (in (mangle '" obj ") --macros--)
;;                     (doc " obj ")
;;                     (help " obj "))")]
;;     (with-repl-or-warn
;;       (fn [repl]
;;         (repl.send
;;           (prep-code code)
;;           (fn [msg]
;;             (log.append (text.prefixed-lines
;;                           (or msg.err msg.out)
;;                           (.. comment-prefix
;;                               (if msg.err "(err) " "(doc) "))))))))))

(defn- display-repl-status [status]
  (let [repl (state :repl)]
    (when repl
      (log.append
        [(.. comment-prefix (a.pr-str (a.get-in repl [:opts :cmd])) " (" status ")")]
        {:break? true}))))

(defn stop []
  (let [repl (state :repl)]
    (when repl
      (repl.destroy)
      (display-repl-status :stopped)
      (a.assoc (state) :repl nil))))

(defn start []
  (if (state :repl)
    (log.append [(.. comment-prefix "Can't start, REPL is already running.")
                 (.. comment-prefix "Stop the REPL with "
                     (config.get-in [:mapping :prefix])
                     (cfg [:mapping :stop]))]
                {:break? true})
    (a.assoc
      (state) :repl
      (stdio.start
        {:prompt-pattern (cfg [:prompt_pattern])
         :cmd (cfg [:command])

         :on-success
         (fn []
           (display-repl-status :started)
           (with-repl-or-warn
             (fn [repl]
               (print repl)
               ;; (repl.send
               ;;   (prep-code "print('test message')"
               ;;     ;; "(import sys) (setv sys.ps2 \"\") (del sys)"
               ;;     ))
               )
             ))

         :on-error
         (fn [err]
           (display-repl-status err))

         :on-exit
         (fn [code signal]
           (when (and (= :number (type code)) (> code 0))
             (log.append [(.. comment-prefix "process exited with code " code)]))
           (when (and (= :number (type signal)) (> signal 0))
             (log.append [(.. comment-prefix "process exited with signal " signal)]))
           (stop))

         :on-stray-output
         (fn [msg]
           (print msg)
           (display-result msg))}))))

(defn on-load []
  (start))

(defn on-exit []
  (stop))

(defn interrupt []
  (log.dbg "sending interrupt message" "")
  (with-repl-or-warn
    (fn [repl]
      (let [uv vim.loop]
        (uv.kill repl.pid uv.constants.SIGINT)))))

(defn on-filetype []
  (mapping.buf :n :PythonStart (cfg [:mapping :start]) *module-name* :start)
  (mapping.buf :n :PythonStop (cfg [:mapping :stop]) *module-name* :stop)
  (mapping.buf :n :PythonInterrupt (cfg [:mapping :interrupt]) *module-name* :interrupt))
