local _2afile_2a = "C:\\Users\\c.kamholtz\\AppData\\Local\\nvim\\fnl\\config\\plugin\\neoclip.fnl"
local _2amodule_name_2a = "config.plugin.neoclip"
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
local neoclip, nvim, telescope = autoload("neoclip"), autoload("aniseed.nvim"), autoload("telescope")
do end (_2amodule_locals_2a)["neoclip"] = neoclip
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["telescope"] = telescope
neoclip.setup()
return telescope.load_extension("neoclip")