(module config.plugin.neogit
  {autoload {autoload aniseed.nvim
             neogit neogit 
             diffview diffview 
             nvim aniseed.nvim
             gitsigns gitsigns 
             which-key which-key}})

(diffview.setup)
(gitsigns.setup
  
  {:on_attach (fn [] 
                (nvim.set_keymap :n "]c" "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'" {:expr true})
                (nvim.set_keymap :n "[c" "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'" {:expr true}))})


(nvim.set_keymap :v :<leader>gl ":<c-u>exe '!git log -L' line(\"'<\").','.line(\"'>\").':'.expand('%')<CR>" {})

(neogit.setup 
  {:integrations {:diffview true}})

(which-key.register 
  {:g {:name "git"
       :g [":lua require'neogit'.open()<cr>" "Open"]}}
  {:prefix "<leader>"})


