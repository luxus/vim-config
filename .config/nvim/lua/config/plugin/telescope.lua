local _2afile_2a = "/home/carl/.config/nvim/fnl/config/plugin/telescope.fnl"
local _2amodule_name_2a = "config.plugin.telescope"
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
local nvim, telescope = autoload("aniseed.nvim"), autoload("telescope")
do end (_2amodule_locals_2a)["nvim"] = nvim
_2amodule_locals_2a["telescope"] = telescope
telescope.setup({defaults = {file_ignore_patterns = {"node_modules"}}, pickers = {find_files = {find_command = {"rg", "--files", "--iglob", "!.git", "--hidden"}}}, extensions = {fzf = {fuzzy = true, ["override-generic-sorter"] = true, ["override-file-sorter"] = true, ["case-mode"] = "smart_case"}}})
telescope.load_extension("fzf")
nvim.set_keymap("n", "<leader>ff", ":lua require('telescope.builtin').find_files()<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>fg", ":lua require('telescope.builtin').live_grep()<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>fb", ":lua require('telescope.builtin').buffers()<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>fh", ":lua require('telescope.builtin').help_tags()<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>fc", ":lua require('telescope.builtin').commands()<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>fz", ":lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", {noremap = true})
return nvim.set_keymap("n", "<leader>fr", ":lua require('telescope.builtin').resume()<CR>", {noremap = true})