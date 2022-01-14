(module config.plugin.neozoom
  {autoload {nvim aniseed.nvim
             neozoom neozoom}})

; if you use `<CR>` as toggle, then you should handle when to fallback yourself so it won't intercept the plain-old `<CR>`.
(vim.api.nvim_set_keymap :n :<CR> "&ft != 'qf' ? '<cmd>NeoZoomToggle<CR>' : '<CR>'" {:noremap true :silent true :nowait true})

