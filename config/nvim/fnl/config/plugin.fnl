(module config.plugin
  {autoload {nvim aniseed.nvim
             a aniseed.core
             util config.util
             packer packer
             vs config.plugin.vs}})

(defn- safe-require-plugin-config [name]
  (let [(ok? val-or-err) (pcall require (.. :config.plugin. name))]
    (when (not ok?)
      (print (.. "config error: " val-or-err)))))

(defn- use [...]
  "Iterates through the arguments as pairs and calls packer's use function for
  each of them. Works around Fennel not liking mixed associative and sequential
  tables as well."
  (let [pkgs [...]
        spec-func 
        (fn [use]
          (for [i 1 (a.count pkgs) 2]
            (let [name (. pkgs i)
                  opts (. pkgs (+ i 1))]
              (-?> (. opts :mod) (safe-require-plugin-config))
              (use (a.assoc opts 1 name)))))

        spec-config {:config {:compile_path (.. (vim.fn.stdpath "config") "/lua/packer_compiled.lua")}}
        spec (a.assoc spec-config 1 spec-func)]

    ;(print (vim.inspect spec))
    (packer.startup spec))
  nil)

;plugins managed by packer
(use
  :lewis6991/impatient.nvim {:mod :impatient}
  ;plugin Manager
  :wbthomason/packer.nvim {}
  ;nvim config and plugins in Fennel
  :Olical/aniseed {:require [:Olical/nvim-local-fennel]
                   :branch :develop}
  ;clojure
  :Olical/conjure {:branch :master :mod :conjure}
  ; which-key
  :folke/which-key.nvim {:mod :whichkey}
  ; tpope
  :tpope/vim-abolish {}
  ;:tpope/vim-commentary {}
  :tpope/vim-surround {}
  :tpope/vim-repeat {}
  :tpope/vim-sensible {}
  :tpope/vim-dispatch {}
  ;;:tpope/vim-vinegar {}
  :tpope/vim-unimpaired {}

  ; comments
  :numToStr/Comment.nvim {:mod :comment}

  ; Text objects
  :wellle/targets.vim {}
  :kana/vim-textobj-user {}
  :kana/vim-textobj-entire {}
  :Julian/vim-textobj-variable-segment {}

  ; Harpoon
  :ThePrimeagen/harpoon {:requires :nvim-lua/plenary.nvim
                         :mod :harpoon}

  ;; movement
  :phaazon/hop.nvim {:branch "v1"
                     :mod :hop}

  :matze/vim-move {:mod :vim-move}

  ;; git
  :tpope/vim-fugitive {:requires [:junegunn/gv.vim :rbong/vim-flog]}
  
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
  ;; :ms-jpq/chadtree {:branch "chad"
  ;;                   :run "python -m chadtree deps"
  ;;                   :mod :chadtree}

  :kyazdani42/nvim-tree.lua {:require :kyazdani42/nvim-web-devicons
                             :mod :nvim-tree}

  ;; session
  :rmagatti/auto-session {}

  ; Show indents
  :lukas-reineke/indent-blankline.nvim {:mod :indent-blankline}

  ; ;; autoread
  ; :djoshea/vim-autoread {}

  ;; zoom
  :nyngwang/NeoZoom.lua {:mod :neozoom}

  ;; lisp
  :tpope/vim-sexp-mappings-for-regular-people {}
  :guns/vim-sexp {}
  :feline-nvim/feline.nvim {:mod :feline}

  ;file searching
  :nvim-telescope/telescope-fzf-native.nvim {:run "make"}
  :nvim-telescope/telescope.nvim {:requires [:kyazdani42/nvim-web-devicons
                                             :rmagatti/session-lens
                                             :TC72/telescope-tele-tabby.nvim
                                             :nvim-telescope/telescope-dap.nvim
                                             :nvim-lua/popup.nvim
                                             :nvim-lua/plenary.nvim
                                             :nvim-telescope/telescope-file-browser.nvim
                                             :LinArcX/telescope-env.nvim
                                             :natecraddock/workspaces.nvim
                                             :fannheyward/telescope-coc.nvim
                                             :ahmedkhalf/project.nvim]
                                  :mod :telescope}

  :junegunn/fzf { :run (lambda [] (vim.cmd "fzf#install()")) }
  :junegunn/fzf.vim {:mod :fzf}

  ; Search
  :pelodelfuego/vim-swoop {:mod :vim-swoop}

  ; quickfix
  :kevinhwang91/nvim-bqf {:mod :bqf
                          :ft [:qf]}

  :wincent/ferret {}

  ; clipboard
  :AckslD/nvim-neoclip.lua {:requires [:nvim-telescope/telescope.nvim]
                            :mod :neoclip}

   ;parsing system
  :nvim-treesitter/nvim-treesitter {:requires [:nvim-treesitter/nvim-treesitter-textobjects
                                               :romgrk/nvim-treesitter-context]
                                    :run ":TSUpdate"
                                    :mod :treesitter}
  ;; lsp
  :williamboman/nvim-lsp-installer {:requires [:RRethy/vim-illuminate
                                               :chen244/csharpls-extended-lsp.nvim
                                               :Hoffs/omnisharp-extended-lsp.nvim
                                               :neovim/nvim-lspconfig]
                                    :mod :lspconfig}
  ; dap
  :mfussenegger/nvim-dap {:requires [:rcarriga/nvim-dap-ui
                                    :theHamsta/nvim-dap-virtual-text]
                         :mod :dap}

  ; buffer history
  :ton/vim-bufsurf {:mod :vim-bufsurf}

  ; autocomplete
  :hrsh7th/nvim-cmp {:requires [:hrsh7th/cmp-nvim-lsp
                                :hrsh7th/cmp-buffer
                                :hrsh7th/cmp-path
                                :hrsh7th/cmp-cmdline
                                :hrsh7th/cmp-nvim-lsp-signature-help
                                :PaterJason/cmp-conjure

                                :hrsh7th/cmp-vsnip
                                :hrsh7th/vim-vsnip]
                     :mod :cmp}

  ; tabout
  ;; :abecodes/tabout.nvim {:require [:nvim-treesitter/nvim-treesitter :hrsh7th/nvim-cmp]
  ;;                        :mod :tabout}

  ; theme
  :bluz71/vim-nightfly-guicolors {:requires [:rebelot/kanagawa.nvim :tomasr/molokai :embark-theme/vim :projekt0n/github-nvim-theme :fenetikm/falcon :marko-cerovac/material.nvim] 
                                  :mod :theme }
  )

(vs.setup {})
