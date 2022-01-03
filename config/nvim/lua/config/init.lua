local _2afile_2a = "C:\\Users\\c.kamholtz\\AppData\\Local\\nvim\\fnl\\config\\init.fnl"
local _2amodule_name_2a = "config.init"
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
local core, nvim, str, util = autoload("aniseed.core"), autoload("aniseed.nvim"), autoload("aniseed.string"), autoload("config.util")
do end (_2amodule_locals_2a)["core"] = core
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["str"] = str
_2amodule_locals_2a["util"] = util
local function noremap(mode, from, to)
  return nvim.set_keymap(mode, from, to, {noremap = true})
end
_2amodule_locals_2a["noremap"] = noremap
nvim.set_keymap("n", "<space>", "<nop>", {noremap = true})
nvim.g.mapleader = " "
nvim.g.maplocalleader = ","
vim.cmd("nnoremap gp `[v`]")
vim.cmd("vmap y y`]")
vim.o.scrolloff = 7
vim.cmd("\n  function! s:VSetSearch(cmdtype)\n    let temp = @s\n    norm! gv\"sy\n    let @/ = '\\V' . substitute(escape(@s, a:cmdtype.'\\'), '\\n', '\\\\n', 'g')\n    let @s = temp\n  endfunction\n\n  xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>\n  xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>\n         ")
vim.o.clipboard = "unnamedplus"
vim.api.nvim_exec(":set clipboard=unnamedplus", true)
nvim.set_keymap("n", "<leader>sv", ":source $MYVIMRC<CR>", {noremap = true})
noremap("i", "jk", "<esc>")
nvim.o.mouse = "a"
nvim.ex.set("nowrap")
do
  local options = {completeopt = "menuone,noselect", ignorecase = true, smartcase = true, clipboard = "unnamedplus"}
  for option, value in pairs(options) do
    core.assoc(nvim.o, option, value)
  end
end
return require("config.plugin")