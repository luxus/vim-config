local _2afile_2a = "C:\\Users\\c.kamholtz\\AppData\\Local\\nvim\\fnl\\config\\plugin\\dap.fnl"
local _2amodule_name_2a = "config.plugin.dap"
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
local dap, dap_ui, nvim, nvim_dap_virtual_text = autoload("dap"), autoload("dapui"), autoload("aniseed.nvim"), autoload("nvim-dap-virtual-text")
do end (_2amodule_locals_2a)["dap"] = dap
_2amodule_locals_2a["dap-ui"] = dap_ui
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["nvim-dap-virtual-text"] = nvim_dap_virtual_text
dap_ui.setup()
nvim_dap_virtual_text.setup()
dap.adapters.chrome = {type = "executable", command = "node", args = {(os.getenv("HOME") .. "/repos/vscode-chrome-debug/out/src/chromeDebug.js")}}
dap.configurations.javascript = {{type = "chrome", request = "attach", program = "${file}", cwd = vim.fn.getcwd(), sourceMaps = true, protocol = "inspector", port = 9222, webRoot = "${workspaceFolder}"}}
dap.configurations.typescriptreact = {{type = "chrome", request = "attach", program = "${file}", cwd = vim.fn.getcwd(), sourceMaps = true, protocol = "inspector", port = 9222, webRoot = "${workspaceFolder}"}}
local function dap_chrome()
  return dap.attach("chrome", dap.configurations.javascriptreact)
end
nvim.set_keymap("n", "<leader>dct", "<cmd>lua require'dap'.continue()<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>dsv", "<cmd>lua require'dap'.step_over()<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>dsi", "<cmd>lua require'dap'.step_into()<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>dso", "<cmd>lua require'dap'.step_out()<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>dtb", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>dsc", "<cmd>lua require'dap.ui.variables'.scopes()<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>dhh", "<cmd>lua require'dap.ui.variables'.hover()<CR>", {noremap = true})
nvim.set_keymap("v", "<leader>dhv", "<cmd>lua require'dap.ui.variables'.visual_hover()<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>duh", "<cmd>lua require'dap.ui.widgets'.hover()<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>duf", "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>dsbr", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>dsbm", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>dro", "<cmd>lua require'dap'.repl.open()<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>drl", "<cmd>lua require'dap'.repl.run_last()<CR>", {noremap = true})
nvim.set_keymap("n", "<leader>dui", "<cmd>lua require'dapui'.toggle()<CR>", {noremap = true})
return nvim.set_keymap("v", "<M-k>", "<Cmd>lua require('dapui').eval()<CR>", {noremap = true})