(module config.plugin.vim-textobj-user
  {autoload {nvim aniseed.nvim}})


(vim.fn.textobj#user#plugin 
  "aspx"
  {:injection {
               :pattern ["<%=\\s*" "\\s*%>"]
               ;; :pattern ["<%=" "%>"]
               ;; :scan "forward"
               :select-a :a=
               :select-i :i= }
   })

(vim.fn.textobj#user#plugin 
  "jquery"
  {:selector {:pattern ["$([\"']\\?" "[\"']\\?)"]
              :select-a :a$
              :select-i :i$ }})
