local _2afile_2a = "C:\\Users\\carlk\\AppData\\Local\\nvim\\fnl\\config\\plugin\\treesitter.fnl"
local _2amodule_name_2a = "config.plugin.treesitter"
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
local treesitter, treesitter_context = autoload("nvim-treesitter.configs"), autoload("treesitter-context")
do end (_2amodule_locals_2a)["treesitter"] = treesitter
_2amodule_locals_2a["treesitter-context"] = treesitter_context
treesitter.setup({highlight = {enable = true}, indent = {enable = true}, ensure_installed = {"clojure", "c_sharp", "javascript", "css"}, textobjects = {select = {enable = true, lookahead = true, keymaps = {af = "@function.outer", ["if"] = "@function.inner", ac = "@class.outer", ic = "@class.inner", aa = "@parameter.outer", ia = "@parameter.inner"}}}})
return treesitter_context.setup()