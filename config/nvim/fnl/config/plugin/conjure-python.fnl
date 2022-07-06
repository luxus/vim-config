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


(defn insert-history [item]
  ;; Init
  (when (not _G.g-msg)
    (global g-msg []))
  (table.insert g-msg item))

(defn clear-history []
  (global g-msg []))

(defn last-history []
  (a.last g-msg))

(set vim.g.conjure#filetype#python :config.plugin.conjure-python) 
(set vim.g.conjure#filetypes [:clojure :fennel :janet :hy :racket :scheme :lua :lisp :python])

;; (when (not (a.some #(= $1 "python") vim.g.conjure#filetypes))
;;   (table.insert vim.g.conjure#filetypes "python"))

(local input-prompt-pattern "In %[%d+%]: ")
(comment 
  ;; pattern for finding
  (string.find "IPython search prompt: In [123]: " input-prompt-pattern)
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
      :prompt_pattern input-prompt-pattern
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

  (let [(row col byte-count) (last-node:start)]
    (cdbgn [row col byte-count]))

  (last-node:end_)
  (last-node:has_error)
  (last-node:child_count)
  (last-node:child (- (last-node:named_child_count) 1))
  (node->has-return-statement last-node 5)
  
  )

(comment
 (cdbgn {:aa (+ 1 2)})

 g-msg
 (clear-history)
 (last-history)

 (: g-msg 2 :node :sexpr)
 (: (. g-msg 2 :node) :sexpr)
 (global last-node (. g-msg 2 :node))
 )

(defn parser->root [parser]
  (-> (parser:parse) (. 1) (: :root)))

(defn get-bufnr []
  (vim.api.nvim_get_current_buf))

(do 

  (defn node->has-return-statement [node bufnr]
    ;; TODO: This require is currently problematic... consider calling impl
    (local f (require :fennel))
    (local vts vim.treesitter)
    (local q vim.treesitter.query)
    (let [parser (vts.get_parser bufnr "python")
          root (parser->root parser)
          ;; query "(block (return_statement)) @blockWithReturnStatement"
          ;; node root ;; overshadow node using root
          query "(return_statement) @blockWithReturnStatement"
          parsed-query (vts.parse_query "python" query)
          (start-row _ _) (node:start)
          (end-row _ _) (node:end_)
          res (parsed-query:iter_matches 
                node 
                bufnr 
                start-row 
                (+ end-row 1) ;; end is exclusive, so add 1
                )]

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
      (insert-history {:node node :iter-matches res :return-statement-count return-statement-count})
      (~= return-statement-count 0)))

  ;; (accumulate [match-found false
  ;;              id m metadata iter-matches-res]
  ;;   (do
  ;;     (or match-found (> (length m) 0))))

  ;; (node->has-return-statement last-node 5)


  (defn python-node? [node extra-pairs]
    ;; debugging
    (print "python node: \n" (ts.node->str node))
    (global last-node node) 
    (log.dbg "sexpr:" (node:sexpr))
    (log.dbg "buffer #: " (get-bufnr))

    ;; result
    (match (node:type)
      :block
      (do
       (not (node->has-return-statement node (get-bufnr))))

      ;; Prevent partial `if` statement evals
      :elif_clause false 
      :else_clause false 
      :return_statement false 

      ;; Prevent eval of attribute instead of attribute call
      :attribute false 
      :call true

      ;; Don't eval PART of an import, we want to eval the ENTIRE import statement
      :aliased_import false 
      :dotted_name false 
      :import_statement true

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

(defn print-and-return [...]
  (log.dbg ...)
  ...)

(defn create-iter [seq]
  {:curr 0
   :seq seq})

(defn has-next [{: curr : seq &as iter}]
  (. seq (+ curr 1)))

(defn next [{: curr : seq &as iter}]
  (tset iter :curr (+ curr 1))
  (. seq iter.curr))

(defn peek-prev [{: curr : seq &as iter}]
  (. seq (- curr 1)))

(defn peek [{: curr : seq &as iter}]
  (. seq (+ curr 1)))

(defn is-prompt [line]
  (string.find line prompt-pattern-start))


(defn set-result-and-can-drop [c p n] 
  "Returns nil if a line can be removed, else, return the line without any prompt text removed. Prompt lines are always preceeded by a newline (because the user has pressed enter) so these are discarded."
  (local new-meta 
    (if (and c.is-blank 
             (or (a.nil? n) ;; no next line
                 (not (?. p :can-drop)))) ;; prev line won't be dropped
      ;; - Drop the final line if it's blank - it's only there because there was a line ending at the end of the msg which was then split on
      ;; - Drop the blank line if the previous line was not dropped. It appears that output (whether printed or evaluated) is always followed by a newline
      {:can-drop true}
      (if c.is-prompt
        {:result (replace-prompt c.line)} ;; c is a prompt, so return with prompt removed
        (if n
          (if (and c.is-blank n.is-prompt)
            ;; next line is a prompt and this line is blank, so throw away
            {:can-drop true} 
            ;; keep this line (it's not a prompt, maybe it's output or printing)
            {:result c.line})
          {:result c.line})))) ;; There's not next line (so no next prompt), so just keep this line
  (a.merge! c new-meta))

(fn set-is-prompt [{: line &as t}] 
  (let [is-prompt (is-prompt line)]
    (a.assoc t :is-prompt is-prompt)))

(fn set-is-blank [{: line &as t}] 
  (let [is-blank (= (length line) 0)]
    (a.assoc t :is-blank is-blank)))

(defn lines->log [lines]
  (let [meta (->> lines 
                  (a.map #(a.assoc {} :line $1))
                  (a.map set-is-prompt)
                  (a.map set-is-blank))
        iter (create-iter meta)]
    (var res [])
    (while (has-next iter)
      (table.insert res (set-result-and-can-drop 
                          (next iter)
                          (peek-prev iter)
                          (peek iter))))
    (a.map #(. $1 :result) res)))

(defn format-display [full-msg]
  ;; TODO: don't hardcode line endings
  (->> (lines->log (str.split full-msg "\r\n"))
       ;; No longer seem to need this
       ;; (a.filter #(~= "" $1))
       ))

(defn- display-result [msg]
  (let [prefix (.. comment-prefix (if msg.err "(err)" "(out)") " ")]
    ;; Consider doing something different for errors
    (->> (format-display (or msg.err msg.out))
         (a.map #(.. prefix $1))
         log.append)))


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


(do 

  ;; (deftest basics
  ;;   (let [l (ll.create [1 2 3])]
  ;;     (t.pr= ["firsts" "aa->bb->elif" "Out[2]: 'aa->return'" "->if" "Out[3]: 6"] 
  ;;          (lines->log (str.split full-test-str "\r\n")) 
  ;;          "get first value")))

  (lines->log (str.split full-test-str "\r\n")) ; 


  (set-is-prompt {:line "   ...: "})
  (set-is-blank {:line "aa"})

  (->> (str.split full-test-str "\r\n")
       (a.map #(a.assoc {} :line $1))
       (a.map set-is-prompt)
       (a.map set-is-blank))
  )

(comment
  (do 
    (lines->log (str.split full-test-str "\r\n"))
  ))


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

(defn prep-code-2 [code range is-std-python] 
  ;; Objectives:
  ;; - [x] Remove blank lines to prevent early eval inside func definitions
  ;;   - Alternatively, add SOME indentation to each line
  ;; - [x] Trim extra indentation from each line where there is inconsistent indentation
  ;;   - Example: Evalutating code from within a func definition
  ;;   - NOT necessary for IPython, but standard Python REPL requires this

  (defn trim-code-left [code num-left]
    (let [s-col (+ num-left 1)
          lines (str.split code "\n")
          trimmed-lines (a.map 
                          ;; sub string from s-col to end (inclusive)
                          #(string.sub $1 s-col -1) 
                          lines)]
      (str.join "\n" trimmed-lines)))

  (defn get-code-metadata [code]
    "Returns a table with the following keys
    :num-lines - number of lines in `code`
    :min-indent - smallest indent detected
    :final-indent - indent of the last line"
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
    "Returns `code` with the appropriate number of newlines appended to cause the REPL to evaluate the code"
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
  (clear-history)
  (last-history)
  g-msg)

(defn eval-str [opts]
;; Example input
;; {:action "eval"
;;  :code "if (True):
;;             print(\"in if of ee\")"
;;  :file-path "c:\\Users\\xxx\\repos\\pytorch-experiment\\src\\test.py"
;;  :on-result #<function: 0x01f5a3e841a0>
;;  :origin "current-form"
;;  :preview "# eval (current-form): if (True): print(\"in if of ee\")"
;;  :range {:end [19 31] :start [18 8]}}
  ;; (cdbgn opts)
  (var last-value nil)
  (with-repl-or-warn
    (fn [repl]
      (local sent (prep-code-2 opts.code (?. opts :range)))
      (repl.send
        sent  
        (fn [msg]
          ;; (insert-history {:code opts.code :sent sent :msg msg})        
          (log.dbg "MSG" msg)
          (let [msgs (format-display (or msg.err msg.out))]
            (set last-value (or (a.last msgs) last-value))
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
;;           (prep-code-2 code)
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
               (repl.send
                 (prep-code-2 "print('You just connected to the IPython REPL with Conjure!')"
                   ;; TODO: from hy, not sure if relevant/useful?
                   ;; "(import sys) (setv sys.ps2 \"\") (del sys)"
                   )))))

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
