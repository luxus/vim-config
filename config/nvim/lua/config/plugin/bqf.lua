local _2afile_2a = "C:\\Users\\carlk\\AppData\\Local\\nvim\\fnl\\config\\plugin\\bqf.fnl"
local _2amodule_name_2a = "config.plugin.bqf"
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
local bqf = autoload("bqf")
do end (_2amodule_locals_2a)["bqf"] = bqf
vim.cmd("    hi BqfPreviewBorder guifg=#50a14f ctermfg=71\n    hi link BqfPreviewRange Search\n")
local function _1_(bufnr)
  local ret = true
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  local fsize = vim.fn.getfsize(bufname)
  if (fsize > (100 * 1024)) then
    ret = false
  elseif bufname:match("^fugitive://") then
    ret = false
  else
  end
  return ret
end
return (require("bqf")).setup({auto_enable = true, preview = {win_height = 12, win_vheight = 12, delay_syntax = 80, border_chars = {"\226\148\131", "\226\148\131", "\226\148\129", "\226\148\129", "\226\148\143", "\226\148\147", "\226\148\151", "\226\148\155", "\226\150\136"}, should_preview_cb = _1_}, func_map = {drop = "o", openc = "O", split = "<C-s>", tabdrop = "<C-t>", tabc = "", ptogglemode = "z,"}, filter = {fzf = {action_for = {["ctrl-s"] = "split", ["ctrl-t"] = "tab drop"}, extra_opts = {"--bind", "ctrl-o:toggle-all", "--prompt", "> "}}}})