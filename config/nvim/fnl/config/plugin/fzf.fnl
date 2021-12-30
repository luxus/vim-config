(module config.plugin.fzf
  {autoload {nvim aniseed.nvim}})

(if (vim.fn.executable "rg")
  (set vim.o.grepprg "rg --vimgrep"))

; if executable("rg") 
;     set grepprg=rg\ --vimgrep 
; endif
