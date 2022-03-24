(module config.plugin.null-ls
  {autoload {nvim aniseed.nvim
             eslint eslint
             null-ls null-ls}})

(null-ls.setup {:sources [null-ls.builtins.formatting.stylua
                          null-ls.builtins.formatting.eslint
                          null-ls.builtins.formatting.spell]})

(eslint.setup {:bin :eslint
               :code_actions {:enable true
                              :apply_on_save {:enable true :types [:problem]}
                              :disable_rule_comment {:enable true
                                                     :location :separate_line}}
               :diagnostics {:enable true
                             :report_unused_disable_directives false
                             :run_on :type}})
