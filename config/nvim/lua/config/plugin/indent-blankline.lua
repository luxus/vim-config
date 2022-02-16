local _2afile_2a = "C:\\Users\\carlk\\AppData\\Local\\nvim\\fnl\\config\\plugin\\indent-blankline.fnl"
local _2amodule_name_2a = "config.plugin.indent-blankline"
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
local indent_blankline = autoload("indent_blankline")
do end (_2amodule_locals_2a)["indent-blankline"] = indent_blankline
vim.opt.list = true
do end (vim.opt.listchars):append("eol:\226\134\180")
return indent_blankline.setup({show_end_of_line = true})