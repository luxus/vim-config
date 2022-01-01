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

