local _2afile_2a = "AppData\\Local\\nvim\\fnl\\config\\plugin\\chadtree.fnl"
local _2amodule_name_2a = "config.plugin.chadtree"
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
local chadtree, nvim = autoload("chadtree"), autoload("aniseed.nvim")
do end (_2amodule_locals_2a)["chadtree"] = chadtree
_2amodule_locals_2a["nvim"] = nvim
return nvim.set_keymap("n", "<leader>v", "<cmd>CHADopen<cr>", {noremap = true})