(module config.plugin.neoclip
  {autoload {nvim aniseed.nvim
             neoclip neoclip
             telescope telescope}})

(neoclip.setup)
(telescope.load_extension "neoclip")
