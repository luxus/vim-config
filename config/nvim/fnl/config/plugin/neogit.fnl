(module config.plugin.neogit
  {autoload {autoload aniseed.nvim
             diffview diffview 
             nvim aniseed.nvim
             gitsigns gitsigns 
             neogit neogit
             which-key which-key}})

(diffview.setup)

(neogit.setup 
  {:integrations {:diffview true}})

; Seems to be using passing in lua functions to keybind.. might not actually work without latest nvim
(gitsigns.setup 
  {:current_line_blame_opts {:ignore_whitespace true}
   :on_attach (fn [bufnr]
        (fn map [mode lhs rhs opts]
          (set-forcibly! opts
                         (vim.tbl_extend :force
                                         {:noremap true
                                          :silent true}
                                         (or opts
                                             {})))
          (vim.api.nvim_buf_set_keymap bufnr mode lhs rhs opts))

        (map :n "]c"
             "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'"
             {:expr true})
        (map :n "[c"
             "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'"
             {:expr true})
        (map :n :<leader>hs
             ":Gitsigns stage_hunk<CR>")
        (map :v :<leader>hs
             ":Gitsigns stage_hunk<CR>")
        (map :n :<leader>hr
             ":Gitsigns reset_hunk<CR>")
        (map :v :<leader>hr
             ":Gitsigns reset_hunk<CR>")
        (map :n :<leader>hS
             "<cmd>Gitsigns stage_buffer<CR>")
        (map :n :<leader>hu
             "<cmd>Gitsigns undo_stage_hunk<CR>")
        (map :n :<leader>hR
             "<cmd>Gitsigns reset_buffer<CR>")
        (map :n :<leader>hp
             "<cmd>Gitsigns preview_hunk<CR>")
        (map :n :<leader>hb
             "<cmd>lua require\"gitsigns\".blame_line{full=true}<CR>")
        (map :n :<leader>tb
             "<cmd>Gitsigns toggle_current_line_blame<CR>")
        (map :n :<leader>hd
             "<cmd>Gitsigns diffthis<CR>")
        (map :n :<leader>hD
             "<cmd>lua require\"gitsigns\".diffthis(\"~\")<CR>")
        (map :n :<leader>td
             "<cmd>Gitsigns toggle_deleted<CR>")
        (map :o :ih
             ":<C-U>Gitsigns select_hunk<CR>")
        (map :x :ih
             ":<C-U>Gitsigns select_hunk<CR>"))})

(nvim.set_keymap :v :<leader>gl ":<c-u>exe 'Git log -L' line(\"'<\").','.line(\"'>\").':'.expand('%:p')<CR>" {:desc "Fugitive git log"})
(nvim.set_keymap :v :<leader>gL ":<c-u>exe '!git log -L' line(\"'<\").','.line(\"'>\").':'.expand('%')<CR>" {:desc "Raw git log"})

(which-key.register 
  {:g {:name "git"
       :g ["<cmd>Git<CR>" "Open"]}}
  {:prefix "<leader>"})


(vim.cmd
 "
 nnoremap gdh :diffget //2<CR>
 nnoremap gdl :diffget //3<CR>
 "
 )

; Copy filename to clipboard
(vim.api.nvim_create_user_command 
  "Git pull" 
  #(vim.cmd "Git pull") 
  {})

(vim.api.nvim_create_user_command 
  "Git push" 
  #(vim.cmd "Git push") 
  {})

(vim.api.nvim_create_user_command 
  "Git checkout master" 
  #(vim.cmd "Git checkout master") 
  {})

(vim.api.nvim_create_user_command 
  "Git checkout -" 
  #(vim.cmd "Git checkout -") 
  {})
