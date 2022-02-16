local _2afile_2a = "C:\\Users\\carlk\\AppData\\Local\\nvim\\fnl\\config\\plugin\\feline.fnl"
local _2amodule_name_2a = "config.plugin.lualine"
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
local feline, nvim = autoload("feline"), autoload("aniseed.nvim")
do end (_2amodule_locals_2a)["feline"] = feline
_2amodule_locals_2a["nvim"] = nvim
nvim.o.termguicolors = true
local vi_mode_utils = require("feline.providers.vi_mode")
local M = {active = {}, inactive = {}}
local function _1_()
  return {name = vi_mode_utils.get_mode_highlight_name(), fg = vi_mode_utils.get_mode_color(), style = "bold"}
end
M.active[1] = {{provider = "\226\150\138 ", hl = {fg = "skyblue"}}, {provider = "vi_mode", hl = _1_}, {provider = {name = "file_info", opts = {type = "unique"}}, hl = {fg = "white", bg = "oceanblue", style = "bold"}, left_sep = {"slant_left_2", {str = " ", hl = {bg = "oceanblue", fg = "NONE"}}}, right_sep = {{str = " ", hl = {bg = "oceanblue", fg = "NONE"}}, "slant_right_2", " "}}, {provider = "file_size", right_sep = {" ", {str = "slant_left_2_thin", hl = {fg = "fg", bg = "bg"}}}}, {provider = "position", left_sep = " ", right_sep = {" ", {str = "slant_right_2_thin", hl = {fg = "fg", bg = "bg"}}}}, {provider = "diagnostic_errors", hl = {fg = "red"}}, {provider = "diagnostic_warnings", hl = {fg = "yellow"}}, {provider = "diagnostic_hints", hl = {fg = "cyan"}}, {provider = "diagnostic_info", hl = {fg = "skyblue"}}}
M.active[2] = {{provider = "git_branch", hl = {fg = "white", bg = "black", style = "bold"}, right_sep = {str = " ", hl = {fg = "NONE", bg = "black"}}}, {provider = "git_diff_added", hl = {fg = "green", bg = "black"}}, {provider = "git_diff_changed", hl = {fg = "orange", bg = "black"}}, {provider = "git_diff_removed", hl = {fg = "red", bg = "black"}, right_sep = {str = " ", hl = {fg = "NONE", bg = "black"}}}, {provider = "line_percentage", hl = {style = "bold"}, left_sep = "  ", right_sep = " "}, {provider = "scroll_bar", hl = {fg = "skyblue", style = "bold"}}}
local function _2_()
  return {name = vi_mode_utils.get_mode_highlight_name(), fg = vi_mode_utils.get_mode_color(), style = "bold"}
end
M.inactive[1] = {{provider = "\226\150\138 ", hl = {fg = "skyblue"}}, {provider = "vi_mode", hl = _2_}, {provider = "file_info", hl = {fg = "white", bg = "oceanblue", style = "bold"}, left_sep = {"slant_left_2", {str = " ", hl = {bg = "oceanblue", fg = "NONE"}}}, right_sep = {{str = " ", hl = {bg = "oceanblue", fg = "NONE"}}, "slant_right_2", " "}}, {provider = "file_size", right_sep = {" ", {str = "slant_left_2_thin", hl = {fg = "fg", bg = "bg"}}}}, {provider = "position", left_sep = " ", right_sep = {" ", {str = "slant_right_2_thin", hl = {fg = "fg", bg = "bg"}}}}, {provider = "diagnostic_errors", hl = {fg = "red"}}, {provider = "diagnostic_warnings", hl = {fg = "yellow"}}, {provider = "diagnostic_hints", hl = {fg = "cyan"}}, {provider = "diagnostic_info", hl = {fg = "skyblue"}}}
return feline.setup({components = M})