(module config.plugin
  {autoload {nvim aniseed.nvim
             a aniseed.core
             util config.util
             packer packer
             ;; should use pcall for this
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
        spec-func (fn [use]
                    (for [i 1 (a.count pkgs) 2]
                      (let [name (. pkgs i)
                            opts (. pkgs (+ i 1))]
                        (-?> (. opts :mod) (safe-require-plugin-config))
                        (use (a.assoc opts 1 name)))))

        compile-path (.. (vim.fn.stdpath "config") "/lua/packer_compiled.lua")
        spec-config {1 spec-func
                     :config {:compile_path compile-path}}]

    ;(print (vim.inspect spec))
    (packer.startup spec-config))
  nil)

;plugins managed by packer
(use
  :lewis6991/impatient.nvim {:mod :impatient}
  ; plugin Manager
  :wbthomason/packer.nvim {}
  ;nvim config and plugins in Fennel
  :Olical/aniseed {:require [:Olical/nvim-local-fennel]
                   :branch :develop}
  ; clojure
  :Olical/conjure {:branch :master :mod :conjure}
  ;; :Kamholtz/conjure {:branch :ck/feat/2022/07/03/python-client :mod :conjure}
  ; https://github.com/Olical/conjure/wiki/Quick-start:-Clojure
  ;; :clojure-vim/vim-jack-in {:require [:tpope/vim-dispatch :radenling/vim-dispatch-neovim]}

  ; which-key
  :folke/which-key.nvim {:mod :whichkey}

  ; tpope
  :tpope/vim-abolish {}
  :tpope/vim-sensible {}
  :tpope/vim-dispatch {}
  :tpope/vim-unimpaired {}

  ; comments
  :numToStr/Comment.nvim {:mod :comment}

  ; Text objects
  :wellle/targets.vim {}
  :kana/vim-textobj-user {:mod :vim-textobj-user}
  :D4KU/vim-textobj-chainmember {}
  :kana/vim-textobj-entire {}
  :Julian/vim-textobj-variable-segment {}
  :AckslD/nvim-trevJ.lua {:mode :revj}

  ; Harpoon
  :ThePrimeagen/harpoon {:requires :nvim-lua/plenary.nvim
                         :mod :harpoon}

  ;; movement
  :ggandor/lightspeed.nvim {:mod :lightspeed}

  :matze/vim-move {:mod :vim-move}

  ;; git
  :tpope/vim-fugitive {:requires [:AndrewRadev/linediff.vim
                                  :cedarbaum/fugitive-azure-devops.vim
                                  :junegunn/gv.vim]}

  :TimUntersberger/neogit {:requires [:nvim-lua/plenary.nvim
                                      :sindrets/diffview.nvim
                                      :lewis6991/gitsigns.nvim]
                           :mod :neogit}

  ;; bufferize
  :AndrewRadev/bufferize.vim {}

  ;; buffers
  :kazhala/close-buffers.nvim {:mod :close-buffers}

  ;; editing
  :mg979/vim-visual-multi {:branch "master"}
  :bkad/CamelCaseMotion {:mod :camelcasemotion}
  :vim-scripts/ReplaceWithRegister {}
  :jiangmiao/auto-pairs {}
  :mbbill/undotree {:mod :undotree}

  ;; folders
  :ms-jpq/chadtree {:branch "chad"
                    :run "python -m chadtree deps"
                    :mod :chadtree}

  ;; session
  :rmagatti/auto-session {:mod :auto-session}

  ; Show indents
  :lukas-reineke/indent-blankline.nvim {:mod :indent-blankline}

  ; autoread
  ; :djoshea/vim-autoread {}

  ;; zoom
  :nyngwang/NeoZoom.lua {:mod :neozoom}

  ;; lisp
  :guns/vim-sexp {:mod :sexp}
  :tpope/vim-sexp-mappings-for-regular-people {}
  :tpope/vim-surround {}
  :tpope/vim-repeat {}
  :hylang/vim-hy {}

  ; Highlighting
  :azabiong/vim-highlighter {:mod :vim-highlighter}

  ;; Cursor-line
  :mvllow/modes.nvim {:mod :modes}

  ; file searching
  :nvim-telescope/telescope-fzf-native.nvim {:run "make"}
  :nvim-telescope/telescope.nvim {:requires [:kyazdani42/nvim-web-devicons
                                             :rmagatti/session-lens
                                             :TC72/telescope-tele-tabby.nvim
                                             :nvim-lua/popup.nvim
                                             :nvim-lua/plenary.nvim
                                             :ahmedkhalf/project.nvim
                                             :nvim-telescope/telescope-file-browser.nvim
                                             :LinArcX/telescope-env.nvim]

                                             ;; :nvim-telescope/telescope-dap.nvim
                                             ;; :natecraddock/workspaces.nvim
                                             ;; :fannheyward/telescope-coc.nvim

                                  :mod :telescope}

  :junegunn/fzf { :run (lambda [] (vim.cmd "fzf#install()"))}
  :junegunn/fzf.vim {:mod :fzf}

  ; quickfix
  :kevinhwang91/nvim-bqf {:mod :bqf
                          :ft [:qf]}

  ; Narrow region
  :chrisbra/NrrwRgn {}

  :wincent/ferret {}

   ;parsing system
  :nvim-treesitter/nvim-treesitter {:requires [:gaelph/logsitter.nvim
                                               :nvim-treesitter/nvim-treesitter-textobjects
                                               :romgrk/nvim-treesitter-context
                                               :windwp/nvim-ts-autotag]
                                    :run ":TSUpdate"
                                    :mod :treesitter}

  ;; line
  :feline-nvim/feline.nvim {:mod :feline
                            :requires []}

  ;; lsp
  :williamboman/nvim-lsp-installer {:requires [:RRethy/vim-illuminate
                                               :chen244/csharpls-extended-lsp.nvim
                                               :j-hui/fidget.nvim
                                               :Hoffs/omnisharp-extended-lsp.nvim
                                               :neovim/nvim-lspconfig]
                                    :mod :lspconfig}




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
  :abecodes/tabout.nvim {:require [:nvim-treesitter/nvim-treesitter :hrsh7th/nvim-cmp]
                         :mod :tabout}


  ; scratch
  :mtth/scratch.vim {:mod :scratch}

  ; REPL
  :geg2102/nvim-python-repl {:mod :nvim-python-repl}
  ;; :jpalardy/vim-slime {:mod :vim-slime}

  ; hydra
  :anuvyklack/hydra.nvim {:mod :hydra
                          ;; These are for window navigation hydra
                          ;; :requires [:jlanzarotta/bufexplorer
                          ;;            :sindrets/winshift.nvim]
                          }

  ; theme
  :bluz71/vim-nightfly-guicolors {:requires [:rebelot/kanagawa.nvim
                                             :RRethy/nvim-base16
                                             :projekt0n/github-nvim-theme
                                             :marko-cerovac/material.nvim
                                             :EdenEast/nightfox.nvim
                                             :fenetikm/falcon
                                             :rktjmp/lush.nvim]
                                  :mod :theme})

  ; Search
  ;; :pelodelfuego/vim-swoop {:mod :vim-swoop}

  ; clipboard
  ;; :AckslD/nvim-neoclip.lua {:requires [:nvim-telescope/telescope.nvim]
  ;;                           :mod :neoclip}

  ;; coc
  ;; :neoclide/coc.nvim {:branch "release"
  ;;                     :mod :coc}

  ;; null-ls
   ;; :jose-elias-alvarez/null-ls.nvim {:requires [:MunifTanjim/eslint.nvim]
   ;;                                   :mod :null-ls}

  ; dap
  ;; :mfussenegger/nvim-dap {:requires [:rcarriga/nvim-dap-ui
  ;;                                   :theHamsta/nvim-dap-virtual-text]
  ;;                        :mod :dap}


;; TODO: Don't run this config if not on windows with powershell
;; Should use pcall for this
(when (= (vim.fn.has :win32) 1)
  (vs.setup {:devenv-path "C:/Program Files/Microsoft Visual Studio/2022/Professional/Common7/IDE/devenv.exe"
             :nvim-listen-address-base "~"}))
