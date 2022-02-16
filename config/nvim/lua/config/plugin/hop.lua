local _2afile_2a = "C:\\Users\\carlk\\AppData\\Local\\nvim\\fnl\\config\\plugin\\hop.fnl"
local _2amodule_name_2a = "config.plugin.hop"
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
local hop, nvim, which_key = autoload("hop"), autoload("aniseed.nvim"), autoload("which-key")
do end (_2amodule_locals_2a)["hop"] = hop
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["which-key"] = which_key
hop.setup()
which_key.register({h = {name = "hop", w = {"<cmd>HopWord<cr>", "Word"}, l = {"<cmd>HopLineStart<cr>", "Line Start"}, f = {"<cmd>HopChar1<cr>", "Char1"}}}, {prefix = "<leader>"})
return nvim.set_keymap("o", "<leader>hw", ":lua require'hop'.hint_words()<cr>", {noremap = true})