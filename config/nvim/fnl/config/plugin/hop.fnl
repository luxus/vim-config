(module config.plugin.hop
  {autoload {nvim aniseed.nvim
             hop hop
             which-key which-key}})

(hop.setup)
(which-key.register 
  { :h {:name "hop" 
        :w ["<cmd>HopWord<cr>" "Word"]
        :l ["<cmd>HopLineStart<cr>" "Line Start"]
        :f ["<cmd>HopChar1<cr>" "Char1"]}}
  { :prefix "<leader>"})

(nvim.set_keymap :o :<leader>hw ":lua require'hop'.hint_words()<cr>" {:noremap true})

(vim.api.nvim_set_keymap :n :f
                         "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
                         {})
(vim.api.nvim_set_keymap :n :F
                         "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
                         {})
(vim.api.nvim_set_keymap :o :f
                         "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>"
                         {})
(vim.api.nvim_set_keymap :o :F
                         "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>"
                         {})
(vim.api.nvim_set_keymap "" :t
                         "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
                         {})
(vim.api.nvim_set_keymap "" :T
                         "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
                         {})	
