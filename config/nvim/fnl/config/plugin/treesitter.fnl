(module config.plugin.treesitter
  {autoload {treesitter nvim-treesitter.configs }})

(treesitter.setup {:highlight {:enable true}
                   :indent {:enable true}
                   :ensure_installed ["clojure"]
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
