(module config.plugin.treesitter
  {autoload {treesitter nvim-treesitter.configs 
             treesitter-context treesitter-context
             logsitter logsitter
             plenary plenary
             nvim aniseed.nvim
             js logsitter.lang.javascript
             logsitter-utils logsitter.utils
             nvim-ts-autotag nvim-ts-autotag}})

(treesitter.setup {:highlight {:enable true}
                   :indent {:enable true}
                   :ensure_installed ["clojure" "c_sharp" "javascript" "css" "fennel"]
                   :textobjects {:select {
                                    :enable true

                                    ; Automatically jump forward to textobj, similar to targets.vim
                                    :lookahead true

                                    :keymaps {
                                      ; You can use the capture groups defined in textobjects.scm
                                      "af" "@function.outer"
                                      "if" "@function.inner"
                                      "ac" "@class.outer"
                                      "ic" "@class.inner"
                                      "aa" "@parameter.outer"
                                      "ia" "@parameter.inner"
      }}}})

(treesitter-context.setup {:max_lines 10})
(nvim-ts-autotag.setup {:filetypes ["html" "xml"]})

(vim.cmd
 "
 augroup Logsitter
 au!
 au  FileType javascript   nnoremap <localleader>lg :Logsitter javascript<cr>
 au  FileType go           nnoremap <localleader>lg :Logsitter go<cr>
 au  FileType lua          nnoremap <localleader>lg :Logsitter lua<cr>
 augroup END
 "
 )


(defn get-insert-string-cmd [s is-above]
  (.. "norm " (if is-above "O" "o") s))

(vim.keymap.set :n :<localleader>dO (fn [] (vim.api.nvim_command (get-insert-string-cmd "debugger;" true))) {:noremap true :desc "Debugger above"})
(vim.keymap.set :n :<localleader>do (fn [] (vim.api.nvim_command (get-insert-string-cmd "debugger;" false))) {:noremap true :desc "Debugger below"})
(vim.keymap.set :n :<localleader>tO (fn [] (vim.api.nvim_command (get-insert-string-cmd "console.trace();" true))) {:noremap true :desc "Trace above"})
(vim.keymap.set :n :<localleader>to (fn [] (vim.api.nvim_command (get-insert-string-cmd "console.trace();" false))) {:noremap true :desc "Trace below"})

; select arg, paste behind, surround with quotes,
(nvim.set_keymap :n :<localleader>la "<cmd>norm yiaPgpS\"`]a, <CR>" {:noremap true})


(defn get-fwd-slash-path [path]
  (-> path
      (string.gsub "\\" "/")
      (string.gsub "//" "/")))

;; todo fix this - might just need to update the plugin - see commits
(set js.log 
     (fn [text position]
      (let [label (text:gsub "\"" "\\\"")
        ;; filepath (vim.fn.expand "%:.")
        ;; filepath (string.gsub (vim.fn.expand "%:.") "\\" "/")
        filepath (get-fwd-slash-path (vim.fn.expand "%:t"))
        line (. position 1)]
        
        (string.format "oconsole.log(\"LS -> %s:%s -> %s: \", %s)" filepath line label text))))



;; (set logsitter-utils.node_text 
;;      (fn [node]
;;        (let [fennel (require :fennel)
;;              x (vim.treesitter.query.get_node_text node 0)]
;;          ;; (table.concat x ", ")
;;          x
;;          )))

;; function M.node_text(node)
;; 	return table.concat(vim.treesitter.query.get_node_text(node, 0), ", ")
;; end

(comment

  (plenary.path.normalize (vim.fn.expand "%:."))
  
  ((. (plenary.path.new (vim.fn.expand "%:.")) :make_relative) "C:\\repos\\vim-config\\")

  (: (plenary.path.new (vim.fn.expand "%:.")) :expand)
  (: (plenary.path.new (vim.fn.expand "%:.")) :make_relative )

  

  )
