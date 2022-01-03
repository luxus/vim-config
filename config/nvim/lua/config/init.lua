local _2afile_2a = "C:\\Users\\carlk\\AppData\\Local\\nvim\\fnl\\config\\init.fnl"
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
local core, fs, nvim, path, scandir, str, util = autoload("aniseed.core"), autoload("aniseed.fs"), autoload("aniseed.nvim"), autoload("plenary.path"), autoload("plenary.scandir"), autoload("aniseed.string"), autoload("config.util")
do end (_2amodule_locals_2a)["core"] = core
_2amodule_locals_2a["fs"] = fs
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["path"] = path
_2amodule_locals_2a["scandir"] = scandir
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
require("config.plugin")
do
  local f = io.popen("dir C:/repos/")
  print("reading file: ", f:read("*a"))
  print("file", f)
  if core["nil?"](f) then
    print("failed")
  else
    print(f:read("*a"))
  end
end
fs.basename(vim.fn.expand("%"))
local function get_files_in_dir()
  return scandir.scan_dir(fs.basename(vim.fn.expand("%")), {hidden = true, depth = 2})
end
_2amodule_2a["get-files-in-dir"] = get_files_in_dir
local function get_similar_files(filename)
  local function _2_(x)
    _G.assert((nil ~= x), "Missing argument x on C:\\Users\\carlk\\AppData\\Local\\nvim\\fnl\\config\\init.fnl:83")
    return print(x)
  end
  local function _3_(x)
    _G.assert((nil ~= x), "Missing argument x on C:\\Users\\carlk\\AppData\\Local\\nvim\\fnl\\config\\init.fnl:82")
    return string.match(x, filename)
  end
  return core.map(_2_, core.filter(_3_, get_files_in_dir()))
end
_2amodule_2a["get-similar-files"] = get_similar_files
local file_suffixes = {"Controller", "ViewComponent", "Model", "Default"}
_2amodule_locals_2a["file-suffixes"] = file_suffixes
local function get_common_name(filename)
  local suffix_patterns
  local function _4_(x)
    _G.assert((nil ~= x), "Missing argument x on C:\\Users\\carlk\\AppData\\Local\\nvim\\fnl\\config\\init.fnl:89")
    return core.str(x, "$")
  end
  suffix_patterns = core.map(_4_, file_suffixes)
  local function _5_(x)
    _G.assert((nil ~= x), "Missing argument x on C:\\Users\\carlk\\AppData\\Local\\nvim\\fnl\\config\\init.fnl:93")
    return string.find(filename, x)
  end
  return core.map(_5_, suffix_patterns)
end
_2amodule_locals_2a["get-common-name"] = get_common_name
string.match("select-person-controller", "select.person.")
return string.match("xxxController", "Controller$")