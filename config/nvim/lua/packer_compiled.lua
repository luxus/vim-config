-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "C:\\Users\\carlk\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?.lua;C:\\Users\\carlk\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?\\init.lua;C:\\Users\\carlk\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?.lua;C:\\Users\\carlk\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?\\init.lua"
local install_cpath_pattern = "C:\\Users\\carlk\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\lua\\5.1\\?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  CamelCaseMotion = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\CamelCaseMotion",
    url = "https://github.com/bkad/CamelCaseMotion"
  },
  ["Comment.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["NeoZoom.lua"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\NeoZoom.lua",
    url = "https://github.com/nyngwang/NeoZoom.lua"
  },
  ReplaceWithRegister = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\ReplaceWithRegister",
    url = "https://github.com/vim-scripts/ReplaceWithRegister"
  },
  aniseed = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\aniseed",
    url = "https://github.com/Olical/aniseed"
  },
  ["auto-pairs"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\auto-pairs",
    url = "https://github.com/jiangmiao/auto-pairs"
  },
  ["auto-session"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\auto-session",
    url = "https://github.com/rmagatti/auto-session"
  },
  ["bufferize.vim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\bufferize.vim",
    url = "https://github.com/AndrewRadev/bufferize.vim"
  },
  chadtree = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\chadtree",
    url = "https://github.com/ms-jpq/chadtree"
  },
  ["close-buffers.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\close-buffers.nvim",
    url = "https://github.com/kazhala/close-buffers.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-conjure"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-conjure",
    url = "https://github.com/PaterJason/cmp-conjure"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-vsnip"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-vsnip",
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  conjure = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\conjure",
    url = "https://github.com/Olical/conjure"
  },
  ["csharpls-extended-lsp.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\csharpls-extended-lsp.nvim",
    url = "https://github.com/chen244/csharpls-extended-lsp.nvim"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  falcon = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\falcon",
    url = "https://github.com/fenetikm/falcon"
  },
  ["feline.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\feline.nvim",
    url = "https://github.com/feline-nvim/feline.nvim"
  },
  ferret = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\ferret",
    url = "https://github.com/wincent/ferret"
  },
  ["fidget.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  fzf = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["github-nvim-theme"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\github-nvim-theme",
    url = "https://github.com/projekt0n/github-nvim-theme"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["gv.vim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\gv.vim",
    url = "https://github.com/junegunn/gv.vim"
  },
  harpoon = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\harpoon",
    url = "https://github.com/ThePrimeagen/harpoon"
  },
  ["hop.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\hop.nvim",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["kanagawa.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\kanagawa.nvim",
    url = "https://github.com/rebelot/kanagawa.nvim"
  },
  ["logsitter.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\logsitter.nvim",
    url = "https://github.com/gaelph/logsitter.nvim"
  },
  ["material.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\material.nvim",
    url = "https://github.com/marko-cerovac/material.nvim"
  },
  ["modes.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\modes.nvim",
    url = "https://github.com/mvllow/modes.nvim"
  },
  molokai = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\molokai",
    url = "https://github.com/tomasr/molokai"
  },
  neogit = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\neogit",
    url = "https://github.com/TimUntersberger/neogit"
  },
  ["nightfox.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nightfox.nvim",
    url = "https://github.com/EdenEast/nightfox.nvim"
  },
  ["nvim-bqf"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\nvim-bqf",
    url = "https://github.com/kevinhwang91/nvim-bqf"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-neoclip.lua"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-neoclip.lua",
    url = "https://github.com/AckslD/nvim-neoclip.lua"
  },
  ["nvim-revJ.lua"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-revJ.lua",
    url = "https://github.com/AckslD/nvim-revJ.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter-context",
    url = "https://github.com/romgrk/nvim-treesitter-context"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["omnisharp-extended-lsp.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\omnisharp-extended-lsp.nvim",
    url = "https://github.com/Hoffs/omnisharp-extended-lsp.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["project.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\project.nvim",
    url = "https://github.com/ahmedkhalf/project.nvim"
  },
  ["session-lens"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\session-lens",
    url = "https://github.com/rmagatti/session-lens"
  },
  ["tabout.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\tabout.nvim",
    url = "https://github.com/abecodes/tabout.nvim"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\targets.vim",
    url = "https://github.com/wellle/targets.vim"
  },
  ["telescope-coc.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope-coc.nvim",
    url = "https://github.com/fannheyward/telescope-coc.nvim"
  },
  ["telescope-dap.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope-dap.nvim",
    url = "https://github.com/nvim-telescope/telescope-dap.nvim"
  },
  ["telescope-env.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope-env.nvim",
    url = "https://github.com/LinArcX/telescope-env.nvim"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-tele-tabby.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope-tele-tabby.nvim",
    url = "https://github.com/TC72/telescope-tele-tabby.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  undotree = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\undotree",
    url = "https://github.com/mbbill/undotree"
  },
  vim = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim",
    url = "https://github.com/embark-theme/vim"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-abolish",
    url = "https://github.com/tpope/vim-abolish"
  },
  ["vim-bufsurf"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-bufsurf",
    url = "https://github.com/ton/vim-bufsurf"
  },
  ["vim-dispatch"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-dispatch",
    url = "https://github.com/tpope/vim-dispatch"
  },
  ["vim-expand-region"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-expand-region",
    url = "https://github.com/terryma/vim-expand-region"
  },
  ["vim-flog"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-flog",
    url = "https://github.com/rbong/vim-flog"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-illuminate"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-illuminate",
    url = "https://github.com/RRethy/vim-illuminate"
  },
  ["vim-move"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-move",
    url = "https://github.com/matze/vim-move"
  },
  ["vim-nightfly-guicolors"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-nightfly-guicolors",
    url = "https://github.com/bluz71/vim-nightfly-guicolors"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-sensible"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-sensible",
    url = "https://github.com/tpope/vim-sensible"
  },
  ["vim-sexp"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-sexp",
    url = "https://github.com/guns/vim-sexp"
  },
  ["vim-sexp-mappings-for-regular-people"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-sexp-mappings-for-regular-people",
    url = "https://github.com/tpope/vim-sexp-mappings-for-regular-people"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-swoop"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-swoop",
    url = "https://github.com/pelodelfuego/vim-swoop"
  },
  ["vim-textobj-chainmember"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-textobj-chainmember",
    url = "https://github.com/D4KU/vim-textobj-chainmember"
  },
  ["vim-textobj-entire"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-textobj-entire",
    url = "https://github.com/kana/vim-textobj-entire"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-textobj-user",
    url = "https://github.com/kana/vim-textobj-user"
  },
  ["vim-textobj-variable-segment"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-textobj-variable-segment",
    url = "https://github.com/Julian/vim-textobj-variable-segment"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-unimpaired",
    url = "https://github.com/tpope/vim-unimpaired"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  },
  ["workspaces.nvim"] = {
    loaded = true,
    path = "C:\\Users\\carlk\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\workspaces.nvim",
    url = "https://github.com/natecraddock/workspaces.nvim"
  }
}

time([[Defining packer_plugins]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType qf ++once lua require("packer.load")({'nvim-bqf'}, { ft = "qf" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
