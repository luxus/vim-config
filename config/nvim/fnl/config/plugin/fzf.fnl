(module config.plugin.fzf
  {autoload {nvim aniseed.nvim}})

(if (vim.fn.executable "rg")
  (set vim.o.grepprg "rg --vimgrep"))

(nvim.set_keymap :n :<leader>fg "<cmd>Rg<CR>" {:noremap true})
