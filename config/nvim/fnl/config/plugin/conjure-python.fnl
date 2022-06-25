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
             ll conjure.linked-list
             f fennel}
   require-macros [conjure.macros
                   config.debug-macros]})

(macro cdbgn [form]
  (list (sym :dbgn) form {:print-fn (sym :log.dbg)}))

;; TODO: 
;; - Handle errors "..." which are a visual feedback for indents 
;;   - Maybe this can be disabled as a param to python interactive
;; - Try using `opts.range.start[1]` in `eval-str` to reindent the first line of opts.code and then remove extra indentation from ALL lines
;; - try treesitter playground in a python file
;; - Figure out how to query from the current node:
;;   - https://www.reddit.com/r/neovim/comments/kx1ceh/need_a_little_help_with_tree_sitter_query_matching/
;; - [x] buffer eval
;; - [ ] root eval
;; - [ ] how to remove all the "...:" from the inline msg on eval

;; - final newline can be removed
;; - Only need to add two newlines if in a definition
;; - Other lines, such as "print()" and multiline list comprehensions only need a single newline
;;  - Just print two for now, later can check if treesitter
;; - If last line is part of definition, remove one newline
;; - else, remove two newlines
(comment 
  vim.g.conjure#filetype#clojure ; "conjure.client.clojure.nrepl"
  vim.g.conjure#filetypes ; ["clojure" "fennel" "janet" "hy" "racket" "scheme" "lua" "lisp"]
  (set vim.g.conjure#debug false)
  (set vim.g.conjure#debug true)
  ;; (dbgn (defn aaa [] (print "aa")) {:debug? true})
  (dbgn {:a "aa"} {:debug? true})
  (dbgn (+ 1 2 3) {:debug? true})

  (dbgn (defn aaa [] (+ 1 2)) {:debug? false})
  (aaa)

  )


(set vim.g.conjure#filetype#python :config.plugin.conjure-python) 
(set vim.g.conjure#filetypes [:clojure :fennel :janet :hy :racket :scheme :lua :lisp :python])

(comment 
  
  ;; pattern for finding
  (string.find "IPython search prompt: In [123]:" "In %[%d+%]:")
; 24
; 32
  )

(config.merge
  {:client
   {:python
    {:stdio
     {:mapping {:start "cs"
                :stop "cS"
                :interrupt "ei"}
      :command "python -m IPython"
      ;; https://stackoverflow.com/questions/55980470/how-to-print-output-of-an-interactive-child-process-from-parent-process
      ;; :command "python -u -i -q"
      ;; :prompt_pattern ">>> "
      :prompt_pattern "In %[%d+%]: "
      }}}}
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

(comment 
  (last-node:sexpr)
  (last-node:type)
  (last-node:start)
  (last-node:end_)
  (last-node:has_error)
  (last-node:child_count)
  (last-node:child (- (last-node:named_child_count) 1))
  (node->has-return-statement last-node 14)
  
  )

(comment
 (cdbgn {:aa (+ 1 2)})
 )

(do 
  (defn parser->root [parser]
    (-> (parser:parse) (. 1) (: :root)))

  (defn get-bufnr []
    (vim.api.nvim_get_current_buf))

  (defn node->has-return-statement [node bufnr]
    (local f (require :fennel))
    (local vts vim.treesitter)
    (local q vim.treesitter.query)
    (let [parser (vts.get_parser bufnr "python")
          root (parser->root parser)
          ;; query "(block (return_statement)) @blockWithReturnStatement"
          ;; node root ;; overshadow node using root
          query "(return_statement) @blockWithReturnStatement"
          parsed-query (vts.parse_query "python" query)
          res (parsed-query:iter_matches node bufnr (node:start) (node:end_))]

      (global iter-matches-res res)
      
      (var return-statement-count 0)
      (each [id m metadata res]
        ;; (cdbgn [id m metadata])
        (when (> (length m) 0)
          (set return-statement-count
               (+ 1 return-statement-count)))

        ;; (cdbgn return-statement-count)
        ;; Returns a table of 1 element
        ;; (cdbgn (q.get_node_text (. m 1) bufnr))
        )

        ;; (cdbgn return-statement-count)
      ;; We cannot evaluate a block with a return statement
      (= return-statement-count 0)))

  ;; (accumulate [match-found false
  ;;              id m metadata iter-matches-res]
  ;;   (do
  ;;     (or match-found (> (length m) 0))))


  (defn python-node? [node extra-pairs]
    ;; debugging
    (print "python node: \n" (ts.node->str node))
    (global last-node node) 
    (log.dbg "sexpr:" (node:sexpr))

    ;; result
    (match (node:type)
      :block
      (do
       (node->has-return-statement node (get-bufnr)))

      :elif_clause false 
      :else_clause false 
      :return_statement false 
      _ true))

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


(local prompt-pattern "[ ]+...: ")
;; match ONE set of \r\n and no more
(local prompt-pattern-start (.. "^" prompt-pattern "[\r]*[\n]*"))

(defn replace-prompt [line has-replaced-once?] 
  ;; Keep replacing prompts until there is no change,
  ;; Returns nil 
  (let [res (string.gsub line prompt-pattern-start "")]
    ;; Any change?
    (if (= (length line) (length res))
      (if (and 
            has-replaced-once? 
            (= (length res) 0))
        nil ;; after removing all the prompts, the string was empty, so discard
        res)
      (replace-prompt res true))))

(defn split-on-newline-prompt [full-msg]
  (str.split 
    full-msg 
    ;;  blank line, prompt
    (.. "\n\r\n" prompt-pattern)))

(defn print-and-return [...]
  (log.dbg ...)
  ...)

(defn format-display [full-msg]
  )

(defn- display-result [msg]
  (let [prefix (.. comment-prefix (if msg.err "(err)" "(out)") " ")]
    (->> (str.split (or msg.err msg.out) "\n")
         (a.map replace-prompt)
         (a.filter #(~= "" $1))
         (a.map #(.. prefix $1))
         log.append)))


(defn create-iter [seq]
  {:curr 0
   :seq seq})

(defn has-next [{: curr : seq &as iter}]
  (. seq (+ curr 1)))

(defn next [{: curr : seq &as iter}]
  (tset iter :curr (+ curr 1))
  (. seq iter.curr))

(defn peek [{: curr : seq &as iter}]
  (. seq (+ curr 1)))

(defn is-prompt [line]
  (string.find line prompt-pattern-start))


    (local full-test-str 
"first\r
\r
   ...:    ...:    ...:    ...:    ...:    ...:    ...:    ...:    ...:    ...:    ...: aa->bb->elif\r
Out[2]: 'aa->return'\r
\r
   ...:    ...: ->if\r
Out[3]: 6\r
\r
   ...:    ...: \r
" )

(comment
  (do 

    (defn parse-line [c p]
      (dbgn c)
      (if (and (str.blank? c) (a.nil? p))
        ;; last line and blank (split at the end of the original text)
        nil 
        (if (dbgn (is-prompt c))
          (replace-prompt c) ;; c is a prompt, so return with prompt removed
          (if p
            (if (and (str.blank? c) (is-prompt p))
              ;; next line is a prompt and this line is blank, so throw away
              nil 
              ;; keep this line
              c)
            c))))

    (let [lines (str.split full-test-str "\r\n")
          iter (create-iter lines)]
      (var res [])
      (while (has-next iter)
        (table.insert res (parse-line 
                            (next iter)
                            (peek iter)))
        (dbgn res))
      res)

    )
  )



(comment

  (do


    (local full-test-str 
"first\r
\r
   ...:    ...:    ...:    ...:    ...:    ...:    ...:    ...:    ...:    ...:    ...: aa->bb->elif\r
Out[2]: 'aa->return'\r
\r
   ...:    ...: ->if\r
Out[3]: 6\r
\r
   ...:    ...: \r
" )

    

    (let [;; split on prompt, including previous blank line
          lines (split-on-newline-prompt full-test-str)

          ;; re-join all the lines
          newline-prompts-removed 
          (str.join 
            "\n" 
            lines)]

      (dbgn split-on-newline-prompt)
      (->> (str.split newline-prompts-removed "\n")
           (a.map #(replace-prompt $1))))
    
    ;; (string.gsub "   ...: abc" "[ ]+...: [ab]*" "*")
    ;; (string.gsub "a" "a" "*")

;;     (replace-prompt
;; "   ...:    ...: end\r
;; \r"
;;       )

    ;; (replace-prompt
    ;;   "aaa"
    ;;   )

  
    )

  (string.gsub 
"   ...:    ...: end\r
\r"
    "^   ...: "
    "*")

  (string.gsub "aaa" "a+" "*")

 "   ...: "
 )

(defn replace-blank-lines [str-in]
  (->> (str.split str-in "\n")
       (a.filter #(not (str.blank? $1)))
       (str.join "\n")))

(comment
 (replace-blank-lines test-fn-str-1)
 )


(defn add-whitespace [code num-ws]
   (var ii num-ws)
   (var code-with-ws code)
   (while (> ii 0)
     (set code-with-ws (.. " " code-with-ws))
     (set ii (a.dec ii)))
   code-with-ws)

(do 
  (defn prep-code-2 [code range is-std-python] 
    ;; Range can be nil, it will assume no extra indentation is necessary
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
    ;; (dbgn range {:print-fn (fn [...] (log.dbg "msg" ...))})


    ;; (string.sub "abcdef" 2 -1)

    (defn trim-code-left [code num-left]
      (let [s-col (+ num-left 1)
            lines (str.split code "\n")
            trimmed-lines (a.map 
                            ;; sub string from s-col to end (inclusive)
                            #(string.sub $1 s-col -1) 
                            lines)]
        (str.join "\n" trimmed-lines)))

    (defn get-code-metadata [code]
       (let [lines (str.split code "\n")
             ;; The indentation of a line is the line length minus the the length of the line with whitespace trimmed from it
             indents (a.map
                       (fn [line]
                         (- (string.len line)
                            (string.len (str.triml line))))
                       lines)

             ;; Exclude lines with no indentation when trying to find the minimum indentation
             non-zero-indents (a.filter #(> $1 0) indents)
             min-indent (if (-> non-zero-indents length (= 0))
                          ;; No indents, probably a single line
                          0 
                          ;; Get smallest indent 
                          (a.reduce 
                            #(math.min $1 $2) 
                            (. non-zero-indents 1)
                            non-zero-indents))

             ;; indentation of the final line
             final-indent (. indents (length indents))]

         ;; Metadata result
         {:num-lines (length indents)
          :min-indent min-indent
          :final-indent final-indent}))

    (defn add-final-newlines [code {: min-indent : final-indent}]
      ;; Add final newlines to the end of the code to represent adding hitting enter for each level of indentation to make python interactive eval the code

      ;; num-newlines to add is the number of levels of indentation + 1
      (let [level-of-indentation (if (and (~= min-indent 0)
                                          (~= final-indent 0))
                                   (/ final-indent min-indent)
                                   0)
            num-newlines (+ 1 level-of-indentation)]

        (fn append-newline [code num-newlines]
          (if (= 0 num-newlines)
            ;; termination
            code
            ;; append
            (append-newline 
              (.. code "\n") 
              (a.dec num-newlines ))))

        (append-newline code num-newlines)))

    (let [s-col (or  
                  ;; get the starting col
                  (?. range :start 2) 
                  ;; else assume 0
                  0) 
          fmt-code (replace-blank-lines code)
          fmt-code-1 (add-whitespace fmt-code s-col)
          fmt-code-2 (trim-code-left fmt-code-1 s-col)
          code-metadata (get-code-metadata fmt-code-2)]

      (if is-std-python 
        ;; Needs additional newlines depending on indentation of final line
        (add-final-newlines fmt-code-2 code-metadata)
        ;; Needs just one newline
        (.. fmt-code-2 (if 
                         ;; If final indent is 0, we can use just one newline to trigger eval
                         (= (. code-metadata :final-indent) 0)
                         "\n"
                         "\n\n")))))
  
  (prep-code-2 
"def aaa():

        if true:

            print('testing-indented-func')
            "
    {:end [2 42] :start [0 4]})
  )

(do 
  (defn prep-code-3 [code range]
    (let [s-col (. range :start 2)
          fmt-code (replace-blank-lines code)
          ]

      (.. "%cpaste\n"
          fmt-code 
          "\04"))
    )
  
  (prep-code-3
"def aaa():

        if true:

            print('testing-indented-func')
            "
    {:end [2 42] :start [0 4]}))


;; python node: 
;;  def ee():
;;         if (True):
;;             print("in if of ee")
;;         else 
;;             print("in else of ee")
;;         return "ee"
;; sexpr: (function_definition name: (identifier) parameters: (parameters) body: (block (if_statement condition: (parenthesized_expression (true)) consequence: (block (expression_statement (call function: (identifier) arguments: (argument_list (string)))))) (ERROR) (expression_statement (call function: (identifier) arguments: (argument_list (string)))) (return_statement (string))))
;; python: evaluating -  {:action "eval"
;;  :code "def ee():
;;         if (True):
;;             print(\"in if of ee\")
;;         else 
;;             print(\"in else of ee\")
;;         return \"ee\""
;;  :file-path "c:\\Users\\xxx\\repos\\pytorch-experiment\\src\\test.py"
;;  :on-result #<function: 0x023ec2347310>
;;  :origin "current-form"
;;  :preview "# eval (current-form): def ee(): if (True): print(\"in if of ee\") el..."
;;  :range {:end [22 18] :start [17 4]}}
(comment 

  (do

    (prep-code-2 "def funcname():")
    (prep-code-2 "(1 + 2)")
    ))

(defn- prep-code [s]
  (.. s "\n"))

(defn insert-history [code sent msg]
  ;; Init
  (when (not g-msg)
    (global g-msg []))
  (table.insert g-msg {:code code :sent sent :msg msg}))

(defn clear-history []
  (global g-msg []))

(defn last-history []
  (a.last g-msg))

(comment 
  (clear-history)
  (last-history)
  g-msg)

(defn eval-str [opts]
;; {:action "eval"
;;  :code "if (True):
;;             print(\"in if of ee\")"
;;  :file-path "c:\\Users\\xxx\\repos\\pytorch-experiment\\src\\test.py"
;;  :on-result #<function: 0x01f5a3e841a0>
;;  :origin "current-form"
;;  :preview "# eval (current-form): if (True): print(\"in if of ee\")"
;;  :range {:end [19 31] :start [18 8]}}
  (print "python: evaluating - " (f.view opts))
  (var last-value nil)
  (with-repl-or-warn
    (fn [repl]
      (local sent (prep-code-2 opts.code (?. opts :range)))
      (repl.send
        sent  
        (fn [msg]
          (insert-history opts.code sent msg)        
          (log.dbg "MSG" msg)
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
                (opts.on-result last-value))))
          ;; Needs to be batch when sending an entire file with multiple returns
          {:batch? true})))))

(defn eval-file [opts]
  (eval-str (a.assoc opts :code (a.slurp opts.file-path))))

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
