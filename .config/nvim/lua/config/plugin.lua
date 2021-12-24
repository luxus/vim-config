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
    packer.startup(_2_)
  end
  return nil
end
_2amodule_locals_2a["use"] = use
return use("wbthomason/packer.nvim", {}, "Olical/aniseed", {branch = "develop"}, "Olical/conjure", {branch = "master", mod = "conjure"}, "folke/which-key.nvim", {mod = "whichkey"}, "tpope/vim-abolish", {}, "tpope/vim-commentary", {}, "tpope/vim-surround", {}, "tpope/vim-repeat", {}, "tpope/vim-sensible", {}, "tpope/vim-dispatch", {}, "tpope/vim-vinegar", {}, "tpope/vim-unimpaired", {}, "neoclide/coc.nvim", {branch = "release", mod = "coc"}, "mg979/vim-visual-multi", {branch = "master"}, "bkad/CamelCaseMotion", {mod = "camelcasemotion"}, "vim-scripts/ReplaceWithRegister", {}, "terryma/vim-expand-region", {}, "jiangmiao/auto-pairs", {}, "mbbill/undotree", {mod = "undotree"}, "ms-jpq/chadtree", {branch = "chad", run = "python -m chadtree deps", mod = "chadtree"}, "rmagatti/auto-session", {}, "tpope/vim-sexp-mappings-for-regular-people", {}, "guns/vim-sexp", {}, "feline-nvim/feline.nvim", {mod = "feline"}, "nvim-telescope/telescope-fzf-native.nvim", {run = "make"}, "nvim-telescope/telescope.nvim", {requires = {"kyazdani42/nvim-web-devicons", "rmagatti/session-lens", "rudism/telescope-vinegar.nvim", "TC72/telescope-tele-tabby.nvim", "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope-project.nvim"}, mod = "telescope"}, "AckslD/nvim-neoclip.lua", {requires = {"nvim-telescope/telescope.nvim"}, mod = "neoclip"}, "nvim-treesitter/nvim-treesitter", {requires = {"nvim-treesitter/nvim-treesitter-textobjects"}, run = ":TSUpdate", mod = "treesitter"}, "williamboman/nvim-lsp-installer", {requires = {"neovim/nvim-lspconfig"}, mod = "lspconfig"}, "hrsh7th/nvim-cmp", {requires = {"hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", "PaterJason/cmp-conjure"}, mod = "cmp"}, "bluz71/vim-nightfly-guicolors", {}, "projekt0n/github-nvim-theme", {mod = "theme"})