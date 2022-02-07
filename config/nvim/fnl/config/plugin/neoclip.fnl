(module config.plugin.neoclip
  {autoload {nvim aniseed.nvim
             neoclip neoclip
             telescope telescope}})

; (neoclip.setup 
;   {:keys {:telescope {:i {:custom { ["<C-p>"] telescope.actions.move_selection_next}}}}})
(telescope.load_extension "neoclip")
