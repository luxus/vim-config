local _2afile_2a = "C:\\Users\\carlk\\AppData\\Local\\nvim\\fnl\\config\\plugin.fnl"
local _2amodule_name_2a = "config.plugin"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local autoload = (require("aniseed.autoload")).autoload
local a, nvim, packer, util = autoload("aniseed.core"), autoload("aniseed.nvim"), autoload("packer"), autoload("config.util")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["packer"] = packer
_2amodule_locals_2a["util"] = util
local function safe_require_plugin_config(name)
  local ok_3f, val_or_err = pcall(require, ("config.plugin." .. name))
  if not ok_3f then
    return print(("config error: " .. val_or_err))
  else
    return nil
  end
end
_2amodule_locals_2a["safe-require-plugin-config"] = safe_require_plugin_config
local function use(...)
  do
    local pkgs = {...}
    local spec_func
    local function _2_(use0)
      for i = 1, a.count(pkgs), 2 do
        local name = pkgs[i]
        local opts = pkgs[(i + 1)]
        do
          local _3_ = opts.mod
          if (nil ~= _3_) then
            safe_require_plugin_config(_3_)
          else
          end
        end
        use0(a.assoc(opts, 1, name))
      end
      return nil
    end
    spec_func = _2_
    local spec_config = {config = {compile_path = (vim.fn.stdpath("config") .. "/lua/packer_compiled.lua")}}
    local spec = a.assoc(spec_config, 1, spec_func)
    packer.startup(spec)
  end
  return nil
end
_2amodule_locals_2a["use"] = use
local function _5_()
  return vim.cmd("fzf#install()")
end
use("lewis6991/impatient.nvim", {mod = "impatient"}, "wbthomason/packer.nvim", {}, "Olical/aniseed", {branch = "develop"}, "Olical/conjure", {branch = "master", mod = "conjure"}, "folke/which-key.nvim", {mod = "whichkey"}, "tpope/vim-abolish", {}, "tpope/vim-surround", {}, "tpope/vim-repeat", {}, "tpope/vim-sensible", {}, "tpope/vim-dispatch", {}, "tpope/vim-unimpaired", {}, "numToStr/Comment.nvim", {mod = "comment"}, "kana/vim-textobj-user", {}, "kana/vim-textobj-entire", {}, "Julian/vim-textobj-variable-segment", {}, "phaazon/hop.nvim", {branch = "v1", mod = "hop"}, "matze/vim-move", {mod = "vim-move"}, "tpope/vim-fugitive", {requires = {"rbong/vim-flog"}}, "TimUntersberger/neogit", {requires = {"nvim-lua/plenary.nvim", "sindrets/diffview.nvim", "lewis6991/gitsigns.nvim"}, mod = "neogit"}, "AndrewRadev/bufferize.vim", {}, "neoclide/coc.nvim", {branch = "release", mod = "coc"}, "mg979/vim-visual-multi", {branch = "master"}, "bkad/CamelCaseMotion", {mod = "camelcasemotion"}, "vim-scripts/ReplaceWithRegister", {}, "terryma/vim-expand-region", {}, "jiangmiao/auto-pairs", {}, "mbbill/undotree", {mod = "undotree"}, "ms-jpq/chadtree", {branch = "chad", run = "python -m chadtree deps", mod = "chadtree"}, "rmagatti/auto-session", {}, "lukas-reineke/indent-blankline.nvim", {mod = "indent-blankline"}, "nyngwang/NeoZoom.lua", {mod = "neozoom"}, "tpope/vim-sexp-mappings-for-regular-people", {}, "guns/vim-sexp", {}, "feline-nvim/feline.nvim", {mod = "feline"}, "nvim-telescope/telescope-fzf-native.nvim", {run = "make"}, "nvim-telescope/telescope.nvim", {requires = {"kyazdani42/nvim-web-devicons", "rmagatti/session-lens", "TC72/telescope-tele-tabby.nvim", "nvim-telescope/telescope-dap.nvim", "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope-file-browser.nvim", "LinArcX/telescope-env.nvim", "natecraddock/workspaces.nvim", "ahmedkhalf/project.nvim"}, mod = "telescope"}, "junegunn/fzf", {run = _5_}, "junegunn/fzf.vim", {mod = "fzf"}, "kevinhwang91/nvim-bqf", {mod = "bqf", ft = {"qf"}}, "wincent/ferret", {}, "AckslD/nvim-neoclip.lua", {requires = {"nvim-telescope/telescope.nvim"}, mod = "neoclip"}, "nvim-treesitter/nvim-treesitter", {requires = {"nvim-treesitter/nvim-treesitter-textobjects", "romgrk/nvim-treesitter-context"}, run = ":TSUpdate", mod = "treesitter"}, "williamboman/nvim-lsp-installer", {requires = {"neovim/nvim-lspconfig"}, mod = "lspconfig"}, "mfussenegger/nvim-dap", {requires = {"rcarriga/nvim-dap-ui", "theHamsta/nvim-dap-virtual-text"}, mod = "dap"}, "ton/vim-bufsurf", {mod = "vim-bufsurf"}, "hrsh7th/nvim-cmp", {requires = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", "PaterJason/cmp-conjure"}, mod = "cmp"}, "bluz71/vim-nightfly-guicolors", {requires = {"tomasr/molokai", "embark-theme/vim", "projekt0n/github-nvim-theme", "fenetikm/falcon", "marko-cerovac/material.nvim"}, mod = "theme"})
return require("packer_compiled")