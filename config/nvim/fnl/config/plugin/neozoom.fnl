(module config.plugin.neozoom
  {autoload {nvim aniseed.nvim
             neo-zoom neo-zoom}})

(neo-zoom.setup {})

(local NOREF_NOERR_TRUNC { :noremap true :silent true :nowait true })
(vim.keymap.set :n :<CR> (fn [] (vim.cmd "NeoZoomToggle")) NOREF_NOERR_TRUNC)
