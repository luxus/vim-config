(module config.plugin.coc
  {autoload {nvim aniseed.nvim
             fs aniseed.fs
             path plenary.path}})

;; (vim.cmd "source ~/AppData/Local/nvim/fnl/config/plugin/coc.vim")

(defn- get-coc-vim-path []
  (let [vimrc-path (vim.fn.expand "$MYVIMRC")
        config-path (fs.basename vimrc-path)]
    (.. config-path "\\lua\\config\\plugin\\coc.vim")))

;; (path.shorten (get-coc-vim-path))
;; (path.exists (get-coc-vim-path))

;; (vim.cmd (.. "source " (get-coc-vim-path)))
(vim.cmd "CocDisable")
