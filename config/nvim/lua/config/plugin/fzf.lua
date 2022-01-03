local _2afile_2a = "C:\\Users\\c.kamholtz\\AppData\\Local\\nvim\\fnl\\config\\plugin\\fzf.fnl"
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
local astring, core, fs, fzf, nvim, path, scandir = autoload("aniseed.string"), autoload("aniseed.core"), autoload("aniseed.fs"), autoload("fzf"), autoload("aniseed.nvim"), autoload("plenary.path"), autoload("plenary.scandir")
do end (_2amodule_locals_2a)["astring"] = astring
_2amodule_locals_2a["core"] = core
_2amodule_locals_2a["fs"] = fs
_2amodule_locals_2a["fzf"] = fzf
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["path"] = path
_2amodule_locals_2a["scandir"] = scandir
if vim.fn.executable("rg") then
  vim.o.grepprg = "rg --vimgrep"
else
end
local function get_this_filename()
  local fullpath = vim.fn.expand("%")
  local base = fs.basename(fullpath)
  local temp = core.first(astring.split(string.gsub(string.gsub(fullpath, base, ""), "^\\", ""), "%."))
  return temp
end
_2amodule_locals_2a["get-this-filename"] = get_this_filename
local function get_files_in_dir()
  return scandir.scan_dir(fs.basename(vim.fn.expand("%")), {hidden = true, depth = 2})
end
_2amodule_2a["get-files-in-dir"] = get_files_in_dir
local function get_similar_files(filename)
  local function _2_(x)
    _G.assert((nil ~= x), "Missing argument x on C:\\Users\\c.kamholtz\\AppData\\Local\\nvim\\fnl\\config\\plugin\\fzf.fnl:43")
    return print(x)
  end
  local function _3_(x)
    _G.assert((nil ~= x), "Missing argument x on C:\\Users\\c.kamholtz\\AppData\\Local\\nvim\\fnl\\config\\plugin\\fzf.fnl:42")
    return string.match(x, filename)
  end
  return core.map(_2_, core.filter(_3_, get_files_in_dir()))
end
_2amodule_2a["get-similar-files"] = get_similar_files
local file_suffixes = {"Controller", "ViewComponent", "Model", "Default"}
_2amodule_locals_2a["file-suffixes"] = file_suffixes
local function get_suffix_pattern(x)
  return core.str(x, "$")
end
_2amodule_locals_2a["get-suffix-pattern"] = get_suffix_pattern
local function get_common_name(filename)
  local filename_exact_pattern = core.str("^", filename, "$")
  local function _4_(x)
    _G.assert((nil ~= x), "Missing argument x on C:\\Users\\c.kamholtz\\AppData\\Local\\nvim\\fnl\\config\\plugin\\fzf.fnl:55")
    return not string.match(x, filename_exact_pattern)
  end
  local function _5_(x)
    _G.assert((nil ~= x), "Missing argument x on C:\\Users\\c.kamholtz\\AppData\\Local\\nvim\\fnl\\config\\plugin\\fzf.fnl:54")
    return string.gsub(filename, get_suffix_pattern(x), "")
  end
  return (core.first(core.filter(_4_, core.map(_5_, file_suffixes))) or filename)
end
_2amodule_locals_2a["get-common-name"] = get_common_name
--[[ (get-common-name "xxxViewComponent") (get-common-name "xxx") ]]--
local function fzf_file_query(query)
  return vim.fn["fzf#vim#files"](".", vim.fn["fzf#vim#with_preview"]({options = {"--query", query, "--layout=reverse", "--info=inline"}}))
end
_2amodule_2a["fzf-file-query"] = fzf_file_query
local function fzf_this_file()
  local this_file = get_this_filename()
  local common_name = get_common_name(this_file)
  print("this-file: ", this_file)
  print("common-name: ", common_name)
  return fzf_file_query(common_name)
end
_2amodule_2a["fzf-this-file"] = fzf_this_file
nvim.set_keymap("n", "<leader>fF", ":lua require'config.plugin.fzf'['fzf-this-file']()<cr>", {noremap = true, silent = false})
--[[ (nvim.set_keymap "n" "<leader>fF" ":lua vim.fn['fzf#vim#files']('.', {options={'--query=aaa', '--layout=reverse', '--info=inline'}})<cr>" {:noremap true :silent false}) (vim.cmd ":lua vim.fn['fzf#vim#files']('.', {options={'--query=aaa', '--layout=reverse', '--info=inline'}})") (vim.api.nvim_command "lua vim.fn['fzf#vim#files']('.', {options={'--query=aaa', '--layout=reverse', '--info=inline'}})") (vim.api.nvim_exec ":lua vim.fn['fzf#vim#files']('.', {options={'--query=aaa', '--layout=reverse', '--info=inline'}})" true) ]]--
return nvim.set_keymap("n", "<leader>fg", "<cmd>Rg<CR>", {noremap = true})