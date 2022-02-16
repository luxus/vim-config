local _2afile_2a = "C:\\Users\\carlk\\AppData\\Local\\nvim\\fnl\\config\\plugin\\neogit.fnl"
local _2amodule_name_2a = "config.plugin.neogit"
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
local autoload0, diffview, gitsigns, neogit, which_key = autoload("aniseed.nvim"), autoload("diffview"), autoload("gitsigns"), autoload("neogit"), autoload("which-key")
do end (_2amodule_locals_2a)["autoload"] = autoload0
_2amodule_locals_2a["diffview"] = diffview
_2amodule_locals_2a["gitsigns"] = gitsigns
_2amodule_locals_2a["neogit"] = neogit
_2amodule_locals_2a["which-key"] = which_key
diffview.setup()
gitsigns.setup()
neogit.setup({integrations = {diffview = true}})
return which_key.register({g = {name = "git", g = {":lua require'neogit'.open()<cr>", "Open"}}}, {prefix = "<leader>"})