(module config.plugin.neogit
  {autoload {autoload aniseed.nvim
             neogit neogit 
             diffview diffview 
             which-key which-key}})

(diffview.setup)
(neogit.setup 
  {:integrations {:diffview true}})

(which-key.register 
  {:g {:name "git"
       :g [":lua require'neogit'.open()<cr>" "Open"]}}
  {:prefix "<leader>"})


