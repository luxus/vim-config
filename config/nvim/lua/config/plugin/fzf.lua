local _2afile_2a = "C:\\Users\\carlk\\AppData\\Local\\nvim\\fnl\\config\\plugin\\fzf.fnl"
local _2amodule_name_2a = "config.plugin.fzf"
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
local fzf, nvim = autoload("fzf"), autoload("aniseed.nvim")
do end (_2amodule_locals_2a)["fzf"] = fzf
_2amodule_locals_2a["nvim"] = nvim
if vim.fn.executable("rg") then
  vim.o.grepprg = "rg --vimgrep"
else
end
return nvim.set_keymap("n", "<leader>fg", "<cmd>Rg<CR>", {noremap = true})