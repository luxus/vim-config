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
local astring, autil, core, fs, fzf, nvim, path, scandir, which_key = autoload("aniseed.string"), autoload("aniseed.nvim.util"), autoload("aniseed.core"), autoload("aniseed.fs"), autoload("fzf"), autoload("aniseed.nvim"), autoload("plenary.path"), autoload("plenary.scandir"), autoload("which-key")
do end (_2amodule_locals_2a)["astring"] = astring
_2amodule_locals_2a["autil"] = autil
_2amodule_locals_2a["core"] = core
_2amodule_locals_2a["fs"] = fs
_2amodule_locals_2a["fzf"] = fzf
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["path"] = path
_2amodule_locals_2a["scandir"] = scandir
_2amodule_locals_2a["which-key"] = which_key
vim.g.fzf_layout = {down = "40%"}
vim.cmd("if has('nvim')\n      tnoremap <expr> <M-r> '<C-\\><C-N>\"'.nr2char(getchar()).'pi'\n  endif")
nvim.set_keymap("v", "<c-f>", "\"hy:Rg<Enter><M-r>h", {})
if vim.fn.executable("rg") then
  vim.o.grepprg = "rg --vimgrep"
else
end
vim.g.fzf_history_dir = "~/.local/share/fzf-history"
local function get_rg_expanded_cmd(x)
  local expanded = vim.fn.expand(x)
  return core.str(":Rg ", expanded)
end
_2amodule_2a["get-rg-expanded-cmd"] = get_rg_expanded_cmd
vim.cmd("\ncommand! -bang -nargs=* GGrep\n\\ call fzf#vim#grep(\n\\   'git grep --line-number -- '.shellescape(<q-args>), 0,\n\\   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)\n")
nvim.set_keymap("n", "<leader>fk", ":GGrep<CR>", {noremap = true})
local function rg_expand(x)
  return vim.cmd(get_rg_expanded_cmd(x))
end
_2amodule_2a["rg-expand"] = rg_expand
--[[ (rg-expand "<cword>") ]]--
local function fzf_root()
  local expanded = (vim.fn.expand("%:p:h") .. ";")
  local path0 = vim.fn.finddir(".git", expanded)
  local subbed = vim.fn.substitute(path0, ".git", "", "")
  local result = vim.fn.fnamemodify(subbed, ":p:h")
  return result
end
_2amodule_2a["fzf-root"] = fzf_root
autil["fn-bridge"]("s:fzf_root", "config.plugin.fzf", "fzf-root")
nvim.set_keymap("n", "<leader>fu", ":exe 'Files ' . <SID>fzf_root()<CR>", {noremap = true})
local function get_lua_cmd(func_name, params)
  return (":lua require('" .. _2amodule_name_2a .. "')['" .. func_name .. "']('" .. astring.join(", ", params) .. "')<CR>")
end
_2amodule_2a["get-lua-cmd"] = get_lua_cmd
nvim.set_keymap("n", "<leader>fwg", get_lua_cmd("rg-expand", {"<cword>"}), {noremap = true})
nvim.set_keymap("n", "<leader>fWg", get_lua_cmd("rg-expand", {"<cWORD>"}), {noremap = true})
nvim.set_keymap("n", "<leader>fwh", ":call fzf#vim#tags(expand('<cword>'))<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>fWh", ":call fzf#vim#tags(expand('<cWORD>'))<CR>", {noremap = true})
local function get_this_full_filename()
  return vim.fn.expand("%")
end
_2amodule_locals_2a["get-this-full-filename"] = get_this_full_filename
local function remove_leading_slash(x)
  return string.gsub(x, "^\\", "")
end
_2amodule_locals_2a["remove-leading-slash"] = remove_leading_slash
local function get_this_filename()
  local fullpath = get_this_full_filename()
  local base = fs.basename(fullpath)
  local temp = core.first(astring.split(remove_leading_slash(string.gsub(fullpath, base, "")), "%."))
  return temp
end
_2amodule_locals_2a["get-this-filename"] = get_this_filename
local function get_files_in_dir()
  return scandir.scan_dir(fs.basename(vim.fn.expand("%")), {hidden = true, depth = 2})
end
_2amodule_2a["get-files-in-dir"] = get_files_in_dir
local function get_similar_files(filename)
  local function _2_(x)
    _G.assert((nil ~= x), "Missing argument x on C:\\Users\\carlk\\AppData\\Local\\nvim\\fnl\\config\\plugin\\fzf.fnl:109")
    return print(x)
  end
  local function _3_(x)
    _G.assert((nil ~= x), "Missing argument x on C:\\Users\\carlk\\AppData\\Local\\nvim\\fnl\\config\\plugin\\fzf.fnl:108")
    return string.match(x, filename)
  end
  return core.map(_2_, core.filter(_3_, get_files_in_dir()))
end
_2amodule_2a["get-similar-files"] = get_similar_files
local function get_parent(full_filename)
  local base1 = fs.basename(full_filename)
  local base2 = fs.basename(base1)
  local parent = remove_leading_slash(string.gsub(base1, base2, ""))
  return parent
end
_2amodule_locals_2a["get-parent"] = get_parent
local file_patterns
local function _4_(filename, full_filename)
  _G.assert((nil ~= full_filename), "Missing argument full-filename on C:\\Users\\carlk\\AppData\\Local\\nvim\\fnl\\config\\plugin\\fzf.fnl:124")
  _G.assert((nil ~= filename), "Missing argument filename on C:\\Users\\carlk\\AppData\\Local\\nvim\\fnl\\config\\plugin\\fzf.fnl:124")
  return get_parent(full_filename)
end
file_patterns = {{suffix = "Controller"}, {suffix = "ViewComponent"}, {suffix = "ViewModel"}, {suffix = "Model"}, {match = "Default", ["callback-fn"] = _4_}}
_2amodule_locals_2a["file-patterns"] = file_patterns
local function get_suffix_pattern(x)
  return core.str(x, "$")
end
_2amodule_locals_2a["get-suffix-pattern"] = get_suffix_pattern
local function remove_suffix(filename, suffix)
  return string.gsub(filename, get_suffix_pattern(suffix), "")
end
_2amodule_locals_2a["remove-suffix"] = remove_suffix
local function get_file_pattern_result(filename, full_filename, pattern)
  local _let_5_ = pattern
  local suffix_str = _let_5_["suffix"]
  local match_str = _let_5_["match"]
  local callback_fn = _let_5_["callback-fn"]
  if suffix_str then
    return remove_suffix(filename, suffix_str)
  elseif match_str then
    if (match_str == filename) then
      return callback_fn(filename, full_filename)
    else
      return nil
    end
  else
    return nil
  end
end
_2amodule_2a["get-file-pattern-result"] = get_file_pattern_result
local function get_common_name(filename, full_filename)
  local function _8_(_241)
    return not ((filename == _241) or core["nil?"](_241))
  end
  local function _9_(_241)
    return get_file_pattern_result(filename, full_filename, _241)
  end
  return (core.first(core.filter(_8_, core.map(_9_, file_patterns))) or filename)
end
_2amodule_locals_2a["get-common-name"] = get_common_name
get_this_full_filename()
--[[ (get-common-name "Default" "config\\nvim\\fnl\\config\\plugin\\Default.fnl") (get-common-name "xxxViewComponent") (get-common-name "xxx") ]]--
local function fzf_file_query(query)
  return vim.fn["fzf#vim#files"](".", vim.fn["fzf#vim#with_preview"]({options = {"--query", query, "--layout=reverse", "--info=inline"}}))
end
_2amodule_2a["fzf-file-query"] = fzf_file_query
local function fzf_this_file()
  local this_file = get_this_filename()
  local this_full_filename = get_this_full_filename()
  local common_name = get_common_name(this_file, this_full_filename)
  print("this-file: ", this_file)
  print("common-name: ", common_name)
  return fzf_file_query(common_name)
end
_2amodule_2a["fzf-this-file"] = fzf_this_file
nvim.set_keymap("n", "<leader>fF", ":lua require'config.plugin.fzf'['fzf-this-file']()<cr>", {noremap = true, silent = false})
--[[ (nvim.set_keymap "n" "<leader>fF" ":lua vim.fn['fzf#vim#files']('.', {options={'--query=aaa', '--layout=reverse', '--info=inline'}})<cr>" {:noremap true :silent false}) (vim.cmd ":lua vim.fn['fzf#vim#files']('.', {options={'--query=aaa', '--layout=reverse', '--info=inline'}})") (vim.api.nvim_command "lua vim.fn['fzf#vim#files']('.', {options={'--query=aaa', '--layout=reverse', '--info=inline'}})") (vim.api.nvim_exec ":lua vim.fn['fzf#vim#files']('.', {options={'--query=aaa', '--layout=reverse', '--info=inline'}})" true) ]]--
nvim.set_keymap("n", "<leader>fg", "<cmd>Rg<CR>", {noremap = true})
vim.g.fzf_preview_window = ""
return nil