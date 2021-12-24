local _2afile_2a = "C:\\Users\\carlk\\AppData\\Local\\nvim\\fnl\\config\\plugin\\feline.fnl"
local _2amodule_name_2a = "config.plugin.lualine"
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
local feline, nvim = autoload("feline"), autoload("aniseed.nvim")
do end (_2amodule_locals_2a)["feline"] = feline
_2amodule_locals_2a["nvim"] = nvim
vim.cmd(":set termguicolors")
return feline.setup()