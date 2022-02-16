local _2afile_2a = "C:\\Users\\carlk\\AppData\\Local\\nvim\\fnl\\config\\plugin\\telescope.fnl"
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
local nvim, nvim_web_devicons, project, telescope, telescope_actions, workspaces = autoload("aniseed.nvim"), autoload("nvim-web-devicons"), autoload("project_nvim"), autoload("telescope"), autoload("telescope.actions"), autoload("workspaces")
do end (_2amodule_locals_2a)["nvim"] = nvim
_2amodule_locals_2a["nvim-web-devicons"] = nvim_web_devicons
_2amodule_locals_2a["project"] = project
_2amodule_locals_2a["telescope"] = telescope
_2amodule_locals_2a["telescope-actions"] = telescope_actions
_2amodule_locals_2a["workspaces"] = workspaces
nvim_web_devicons.setup({default = true})
telescope.setup({defaults = {file_ignore_patterns = {"node_modules"}, mappings = {i = {["<C-Down>"] = telescope_actions.cycle_history_next, ["<C-Up>"] = telescope_actions.cycle_history_prev}}}, pickers = {grep_string = {theme = "ivy"}, current_buffer_fuzzy_find = {theme = "ivy"}, find_files = {theme = "ivy", find_command = {"rg", "--files", "--iglob", "!.git", "--hidden"}}}, extensions = {fzf = {fuzzy = true, ["override-generic-sorter"] = true, ["override-file-sorter"] = true, ["case-mode"] = "smart_case"}, tele_tabby = {use_highlighter = true}}})
workspaces.setup({hooks = {open = {"Telescope find_files"}}})
telescope.load_extension("workspaces")
telescope.load_extension("fzf")
telescope.load_extension("projects")
telescope.load_extension("dap")
telescope.load_extension("file_browser")
telescope.load_extension("env")
project.setup({manual_mode = false, exclude_dirs = {"~/source/repos/fairplayams/", "~/source/repos/fairplayams2/"}, detection_methods = {"pattern", "lsp"}, silent_chdir = true, patterns = {".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "!>AMSApp", ">Applications", "*.sln"}})
vim.cmd("autocmd User TelescopePreviewerLoaded setlocal wrap")
nvim.set_keymap("n", "<leader>ff", ":lua require('telescope.builtin').find_files()<CR>", {noremap = true})
nvim.set_keymap("x", "<leader>fv", ":lua require('telescope.builtin').grep_string()<CR>", {})
nvim.set_keymap("n", "<leader>fv", ":lua require('telescope.builtin').grep_string()<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>fi", ":lua require('telescope.builtin').command_history()<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>fb", ":lua require('telescope.builtin').buffers()<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>fh", ":lua require('telescope.builtin').help_tags()<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>fd", ":lua require('telescope').extensions.file_browser.file_browser()<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>fc", ":lua require('telescope.builtin').commands()<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>fz", ":lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>fr", ":lua require('telescope.builtin').resume()<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>fp", ":lua require'telescope'.extensions.projects.projects{}<CR>", {noremap = true, silent = true})
nvim.set_keymap("n", "<leader>ft", ":lua require('telescope').extensions.tele_tabby.list()<CR>", {noremap = true, silent = true})
nvim.set_keymap("n", "<leader>fs", ":lua require('session-lens').search_session()<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>dcc", "<cmd>lua require'telescope'.extensions.dap.commands{}<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>dco", "<cmd>lua require'telescope'.extensions.dap.configurations{}<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>dlb", "<cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>dv", "<cmd>lua require'telescope'.extensions.dap.variables{}<CR>", {noremap = true})
return nvim.set_keymap("n", "<leader>df", "<cmd>lua require'telescope'.extensions.dap.frames{}<CR>", {noremap = true})