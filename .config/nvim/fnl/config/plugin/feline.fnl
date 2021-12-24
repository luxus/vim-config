(module config.plugin.lualine
  {autoload {nvim aniseed.nvim
             feline feline}})

(vim.cmd ":set termguicolors")
(feline.setup)
