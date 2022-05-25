(module config.plugin.whichkey
  {autoload {which-key which-key}})

(let [(ok? which-key) (pcall #(require :which-key))]
  (when ok?
    ; Temporary hack for handling <c-r> in telescope
    (let [show which-key.show]
      (set which-key.show 
           (fn [keys opts]
             (let [map "<c-r>" 
                   key (vim.api.nvim_replace_termcodes map true false true)]
               (if (= vim.bo.filetype "TelescopePrompt")
                 (vim.api.nvim_feedkeys key "i" true))

               (show keys opts)))))
    (which-key.setup {:plugins {:presets {:operators false}}})))


