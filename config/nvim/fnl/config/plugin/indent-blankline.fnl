(module config.plugin.indent-blankline
  {autoload {indent-blankline indent_blankline }})

(defn setup-whitespace-opts []
  (set vim.opt.list true)
  (vim.opt.listchars:append "eol:↴"))

(comment 
  vim.opt.listchars

  ;; No longer in use

  (indent-blankline.setup {:show_end_of_line false 
                           :show_current_context true
                           :show_current_context_start true})

  (vim.cmd "IndentBlanklineDisable!")
  )

