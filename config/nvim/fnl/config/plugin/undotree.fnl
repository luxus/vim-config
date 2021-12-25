(module config.plugin.undotree 
  {autoload {nvim aniseed.nvim }})

(nvim.set_keymap :n :<F5> ":UndotreeToggle<CR>" {:noremap true})
