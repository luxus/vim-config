(module config.plugin.chadtree
  {autoload {nvim aniseed.nvim
             chadtree chadtree}})

(nvim.set_keymap :n :<leader>v :<cmd>CHADopen<cr> {:noremap true})

