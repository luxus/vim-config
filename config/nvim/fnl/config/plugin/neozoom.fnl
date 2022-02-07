(module config.plugin.neozoom
  {autoload {nvim aniseed.nvim
             neozoom neozoom}})

; if you use `<CR>` as toggle, then you should handle when to fallback yourself so it won't intercept the plain-old `<CR>`.
; (vim.api.nvim_set_keymap :n :<CR> "&ft != 'qf' ? '<cmd>NeoZoomToggle<CR>' : '<CR>'" {:noremap true :silent true :nowait true})

; Tmux-like window-split (and jumps).

; (neozoom.setup)

; (require "neozoom")

; if you use `<CR>` as toggle, then you should handle when to fallback yourself so it won't intercept the plain-old `<CR>`.
; vim.api.nvim_set_keymap('n', '<CR>', "&ft != 'qf' ? '<cmd>NeoZoomToggle<CR>' : '<CR>'", { noremap=true, silent=true, nowait=true })

(nvim.set_keymap :n "<C-W>\"" ":NeoSplit<CR>" {:nowait true :silent true :noremap true})
(nvim.set_keymap :n "<C-W>%" ":NeoVSplit<CR>" {:nowait true :silent true :noremap true})	
