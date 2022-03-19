(module config.plugin.modes
  {autoload {nvim aniseed.nvim
             modes modes}})

(set vim.o.cursorline true)
(modes.setup)
