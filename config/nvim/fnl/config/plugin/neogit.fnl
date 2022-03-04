(module config.plugin.neogit
  {autoload {autoload aniseed.nvim
             neogit neogit 
             diffview diffview 
             nvim aniseed.nvim
             gitsigns gitsigns 
             which-key which-key}})

	

(diffview.setup)
;; (gitsigns.setup
;;   
;;   {:on_attach (fn [] 
;;                 
;;                 (local gs package.loaded.gitsigns)	 
;;
;;                 (fn map [mode l r opts]
;;                   (set-forcibly! opts (or opts {}))
;;                   (set opts.buffer bufnr)
;;                   (vim.keymap.set mode l r opts))
;;
;;                 ; Navigation
;;                 (nvim.set_keymap :n "]c" "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'" {:expr true})
;;                 (nvim.set_keymap :n "[c" "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'" {:expr true})
;;                 ; Actions
;;
;;                 (map [:n :v] :<leader>hs ":Gitsigns stage_hunk<CR>")
;;                 (map [:n :v] :<leader>hr ":Gitsigns reset_hunk<CR>")
;;                 (map :n :<leader>hS gs.stage_buffer)
;;                 (map :n :<leader>hu gs.undo_stage_hunk)
;;                 (map :n :<leader>hR gs.reset_buffer)
;;                 (map :n :<leader>hp gs.preview_hunk)
;;                 (map :n :<leader>hb (fn []
;;                                       (gs.blame_line {:full true})))
;;                 (map :n :<leader>tb gs.toggle_current_line_blame)
;;                 (map :n :<leader>hd gs.diffthis)
;;                 (map :n :<leader>hD (fn []
;;                                       (gs.diffthis "~")))
;;                 (map :n :<leader>td gs.toggle_deleted)
;;                 (map [:o :x] :ih ":<C-U>Gitsigns select_hunk<CR>")	
;;                                                     
;;                                                     )})

; Seems to be using passing in lua functions to keybind.. might not actually work without latest nvim
(gitsigns.setup 
  {:on_attach (fn [bufnr]
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

(nvim.set_keymap :v :<leader>gl ":<c-u>exe '!git log -L' line(\"'<\").','.line(\"'>\").':'.expand('%')<CR>" {})

;; (neogit.setup 
;;   {:integrations {:diffview true}})

(which-key.register 
  {:g {:name "git"
       :g ["<cmd>Git<CR>" "Open"]}}
  {:prefix "<leader>"})


