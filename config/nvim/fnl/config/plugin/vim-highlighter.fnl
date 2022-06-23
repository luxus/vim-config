(module config.plugin.vim-highlighter
  {autoload {nvim aniseed.nvim
             a aniseed.core
             str aniseed.string}})

(global HiSet   :f<CR>)
(global HiErase :f<BS>)
(global HiClear :f<C-L>)
(global HiFind  :f<Tab>)

(nvim.set_keymap :n "<CR>" "<Cmd>Hi><CR>" {:noremap true :desc "Hi/next"})
(nvim.set_keymap :n "g<CR>" "<Cmd>Hi<<CR>" {:noremap true :desc "Hi/prev"})
(nvim.set_keymap :n "[<CR>" "<Cmd>Hi{<CR>" {:noremap true :desc "Hi/older"})
(nvim.set_keymap :n "]<CR>" "<Cmd>Hi}<CR>" {:noremap true :desc "Hi/newer"})


(fn hi->quickfix [] 
  (let [pattern (->> (vim.call "highlighter#List")
                     (a.map #(. $1 :pattern))
                     (str.join "\\v|"))]
    (vim.cmd (.. "vimgrep /\\v(" pattern "\\v)/gj % | copen"))))

(vim.keymap.set :n :<leader>hg hi->quickfix {:noremap true :desc "Highlights->Quickfix"})

;; :exe 'vimgrep /\v('. HiList()->map({i,v -> v.pattern})->join('\v|'). '\v)/gj %' | copen




