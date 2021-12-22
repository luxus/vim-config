local _2afile_2a = "/home/carl/.config/nvim/fnl/config/plugin/undotree.fnl"
local _2amodule_name_2a = "config.plugin.undotree"
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
local nvim = autoload("aniseed.nvim")
do end (_2amodule_locals_2a)["nvim"] = nvim
return nvim.set_keymap("n", "<F5>", ":UndotreeToggle<CR>", {noremap = true})