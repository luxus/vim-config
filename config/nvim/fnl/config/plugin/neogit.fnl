(module config.plugin.neogit
  {autoload {autoload aniseed.nvim
             neogit neogit 
             diffview diffview 
             gitsigns gitsigns 
             which-key which-key}})

(diffview.setup)
(gitsigns.setup)
(neogit.setup 
  {:integrations {:diffview true}})

(which-key.register 
  {:g {:name "git"
       :g [":lua require'neogit'.open()<cr>" "Open"]}}
  {:prefix "<leader>"})


