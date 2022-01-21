(module config.plugin.vim-bufsurf
  {autoload {nvim aniseed.nvim}})

(nvim.set_keymap :n "[b" ":BufSurfBack<CR>" {:noremap true :silent true})
(nvim.set_keymap :n "]b" ":BufSurfForward<CR>" {:noremap true :silent true})
