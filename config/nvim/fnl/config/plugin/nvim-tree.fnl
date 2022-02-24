(module config.plugin.nvim-tree
  {autoload {nvim aniseed.nvim
             nvim-tree nvim-tree}})

(nvim-tree.setup {:update_cwd true
                  :update_focused_file {:enable true
                                        :update_cwd true}})
