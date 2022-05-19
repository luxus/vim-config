(module config.plugin.treesitter
  {autoload {treesitter nvim-treesitter.configs 
             treesitter-context treesitter-context
             logsitter logsitter
             plenary plenary
             nvim aniseed.nvim
             js logsitter.lang.javascript}})

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

(treesitter-context.setup)

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

(vim.keymap.set :n :<localleader>dO (fn [] (vim.api.nvim_command (get-insert-string-cmd "debugger;" true))) {:noremap true})
(vim.keymap.set :n :<localleader>do (fn [] (vim.api.nvim_command (get-insert-string-cmd "debugger;" false))) {:noremap true})
(vim.keymap.set :n :<localleader>tO (fn [] (vim.api.nvim_command (get-insert-string-cmd "console.trace();" true))) {:noremap true})
(vim.keymap.set :n :<localleader>to (fn [] (vim.api.nvim_command (get-insert-string-cmd "console.trace();" false))) {:noremap true})

; select arg, paste behing, surround with quotes,
(nvim.set_keymap :n :<localleader>la "<cmd>norm yiaPgpS\"`]a, <CR>" {:noremap true})


(defn get-fwd-slash-path [path]
  (-> path
      (string.gsub "\\" "/")
      (string.gsub "//" "/")))

(set js.log 
     (fn [text position]
      (let [label (text:gsub "\"" "\\\"")
        ;; filepath (vim.fn.expand "%:.")
        ;; filepath (string.gsub (vim.fn.expand "%:.") "\\" "/")
        filepath (get-fwd-slash-path (vim.fn.expand "%:t"))
        line (. position 1)]
        
        (string.format "oconsole.log(\"LS -> %s:%s -> %s: \", %s)" filepath line label text))))

(comment

  (plenary.path.normalize (vim.fn.expand "%:."))
  
  ((. (plenary.path.new (vim.fn.expand "%:.")) :make_relative) "C:\\repos\\vim-config\\")

  (: (plenary.path.new (vim.fn.expand "%:.")) :expand)
  (: (plenary.path.new (vim.fn.expand "%:.")) :make_relative )

  

  )
