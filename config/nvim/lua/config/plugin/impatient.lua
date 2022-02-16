local _2afile_2a = "C:\\Users\\carlk\\AppData\\Local\\nvim\\fnl\\config\\plugin\\impatient.fnl"
local _2amodule_name_2a = "config.plugin.impatient"
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
local impatient, nvim = autoload("impatient"), autoload("aniseed.nvim")
do end (_2amodule_locals_2a)["impatient"] = impatient
_2amodule_locals_2a["nvim"] = nvim
return impatient.enable_profile()