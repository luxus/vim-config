(module config.plugin.hapoon
  {autoload {nvim aniseed.nvim
             harpoon harpoon}})

(harpoon.setup {})

(nvim.set_keymap :n :<leader>hm ":lua require('harpoon.mark').add_file()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>hq ":lua require('harpoon.ui').toggle_quick_menu()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>hj ":lua require('harpoon.ui').nav_next()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>hk ":lua require('harpoon.ui').nav_prev()<CR>" {:noremap true})
