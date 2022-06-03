(module config.plugin.vim-highlighter
  {autoload {nvim aniseed.nvim}})

(global HiSet   :f<CR>)
(global HiErase :f<BS>)
(global HiClear :f<C-L>)
(global HiFind  :f<Tab>)

(nvim.set_keymap :n "<CR>" "<Cmd>Hi><CR>" {:noremap true :desc "Hi/next"})
(nvim.set_keymap :n "g<CR>" "<Cmd>Hi<<CR>" {:noremap true :desc "Hi/prev"})
(nvim.set_keymap :n "[<CR>" "<Cmd>Hi{<CR>" {:noremap true :desc "Hi/older"})
(nvim.set_keymap :n "]<CR>" "<Cmd>Hi}<CR>" {:noremap true :desc "Hi/newer"})
