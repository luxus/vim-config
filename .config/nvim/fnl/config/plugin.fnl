(module config.plugin
  {autoload {nvim aniseed.nvim
             a aniseed.core
             util config.util
             packer packer}})

(defn- safe-require-plugin-config [name]
  (let [(ok? val-or-err) (pcall require (.. :config.plugin. name))]
    (when (not ok?)
      (print (.. "config error: " val-or-err)))))

(defn- use [...]
  "Iterates through the arguments as pairs and calls packer's use function for
  each of them. Works around Fennel not liking mixed associative and sequential
  tables as well."
  (let [pkgs [...]]
    (packer.startup
      (fn [use]
        (for [i 1 (a.count pkgs) 2]
          (let [name (. pkgs i)
                opts (. pkgs (+ i 1))]
            (-?> (. opts :mod) (safe-require-plugin-config))
            (use (a.assoc opts 1 name)))))))
  nil)

;plugins managed by packer
(use
  ;plugin Manager
  :wbthomason/packer.nvim {}
  ;nvim config and plugins in Fennel
  :Olical/aniseed {:branch :develop}
  ;clojure
  :Olical/conjure {:branch :master :mod :conjure}
  ; which-key
  :folke/which-key.nvim {:mod :whichkey}
  ; tpope
  :tpope/vim-abolish {}
  :tpope/vim-commentary {}
  :tpope/vim-surround {}
  :tpope/vim-repeat {}
  :tpope/vim-sensible {}
  :tpope/vim-unimpaired {}
  :tpope/vim-vinegar {}
  :tpope/vim-dispatch {}
   
  ;; coc
  :neoclide/coc.nvim {:branch "release"
                      :mod :coc}

  ;; editing
  :mg979/vim-visual-multi {:branch "master"}
  :bkad/CamelCaseMotion {:mod :camelcasemotion}
  :vim-scripts/ReplaceWithRegister {}
  :terryma/vim-expand-region {}
  :jiangmiao/auto-pairs {}
  :mbbill/undotree {:mod :undotree}

  ;; session
  :rmagatti/auto-session {}

  ;; lisp
  :tpope/vim-sexp-mappings-for-regular-people {}
  :guns/vim-sexp {}

  ;file searching
  :nvim-telescope/telescope-fzf-native.nvim {:run "make"}
  :nvim-telescope/telescope.nvim {:requires [:rmagatti/session-lens
                                             :rudism/telescope-vinegar.nvim
                                             :TC72/telescope-tele-tabby.nvim
                                             :nvim-lua/popup.nvim
                                             :nvim-lua/plenary.nvim
                                             :nvim-telescope/telescope-project.nvim]
                                  :mod :telescope}
  ;parsing system
  :nvim-treesitter/nvim-treesitter {:requires [:nvim-treesitter/nvim-treesitter-textobjects]
                                    :run ":TSUpdate"
                                    :mod :treesitter}
  ;lsp
  :williamboman/nvim-lsp-installer {:requires [:neovim/nvim-lspconfig]
                          :mod :lspconfig}
  ;autocomplete
  :hrsh7th/nvim-cmp {:requires [:hrsh7th/cmp-buffer
                                :hrsh7th/cmp-nvim-lsp
                                :PaterJason/cmp-conjure]
                     :mod :cmp}
  ;theme
  :projekt0n/github-nvim-theme {:mod :theme})
