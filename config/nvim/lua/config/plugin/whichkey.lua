local _2afile_2a = "C:\\Users\\carlk\\AppData\\Local\\nvim\\fnl\\config\\plugin\\whichkey.fnl"
local _2amodule_name_2a = "config.plugin.whichkey"
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
local which_key = autoload("which-key")
do end (_2amodule_locals_2a)["which-key"] = which_key
local ok_3f, which_key0 = nil, nil
local function _1_()
  return require("which-key")
end
ok_3f, which_key0 = pcall(_1_)
if ok_3f then
  return which_key0.setup({})
else
  return nil
end