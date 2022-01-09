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
  :tpope/vim-dispatch {}
  ;;:tpope/vim-vinegar {}
  :tpope/vim-unimpaired {}

  ;; movement
  :phaazon/hop.nvim {:branch "v1"
                     :mod :hop}

  ;; git
  :TimUntersberger/neogit {:requires [:nvim-lua/plenary.nvim 
                                      :sindrets/diffview.nvim
                                      :lewis6991/gitsigns.nvim]
                           :mod :neogit}

  ;; bufferize
  :AndrewRadev/bufferize.vim {}

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
  ;; folders
  :ms-jpq/chadtree {:branch "chad"
                    :run "python -m chadtree deps"
                    :mod :chadtree}

  ;; session
  :rmagatti/auto-session {}

  ; ;; autoread
  ; :djoshea/vim-autoread {}

  ;; lisp
  :tpope/vim-sexp-mappings-for-regular-people {}
  :guns/vim-sexp {}
  :feline-nvim/feline.nvim {:mod :feline}

  ;file searching
  :nvim-telescope/telescope-fzf-native.nvim {:run "make"}
  :nvim-telescope/telescope.nvim {:requires [:kyazdani42/nvim-web-devicons
                                             :rmagatti/session-lens
                                             ; :rudism/telescope-vinegar.nvim
                                             :TC72/telescope-tele-tabby.nvim
                                             :nvim-telescope/telescope-dap.nvim
                                             :nvim-lua/popup.nvim
                                             :nvim-lua/plenary.nvim
                                             :LinArcX/telescope-env.nvim
                                             :ahmedkhalf/project.nvim]
                                  :mod :telescope}

 :junegunn/fzf { :run (lambda [] (vim.cmd "fzf#install()")) }
 :junegunn/fzf.vim {:mod :fzf}

  ; clipboard
  :AckslD/nvim-neoclip.lua {:requires [:nvim-telescope/telescope.nvim]
                            :mod :neoclip}

  ;parsing system
  :nvim-treesitter/nvim-treesitter {:requires [:nvim-treesitter/nvim-treesitter-textobjects]
                                    :run ":TSUpdate"
                                    :mod :treesitter}
  ;;lsp
  :williamboman/nvim-lsp-installer {:requires [:neovim/nvim-lspconfig]
                                    :mod :lspconfig}
  ; dap
  :mfussenegger/nvim-dap {:requires [:rcarriga/nvim-dap-ui
                                    :theHamsta/nvim-dap-virtual-text]
                         :mod :dap}

  ;autocomplete
  :hrsh7th/nvim-cmp {:requires [ :hrsh7th/cmp-nvim-lsp
                                :hrsh7th/cmp-buffer
                                :hrsh7th/cmp-path
                                :hrsh7th/cmp-cmdline
                                :PaterJason/cmp-conjure]
                     :mod :cmp}
  ;theme

  :bluz71/vim-nightfly-guicolors {:requires [:tomasr/molokai :embark-theme/vim]
                                  :mod :theme }
  ; :projekt0n/github-nvim-theme {:mod :theme}

  )
