local _2afile_2a = "C:\\Users\\carlk\\AppData\\Local\\nvim\\fnl\\config\\plugin\\lspconfig.fnl"
local _2amodule_name_2a = "config.plugin.lspconfig"
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
local cmplsp, lsp, nvim = autoload("cmp_nvim_lsp"), autoload("lspconfig"), autoload("aniseed.nvim")
do end (_2amodule_locals_2a)["cmplsp"] = cmplsp
_2amodule_locals_2a["lsp"] = lsp
_2amodule_locals_2a["nvim"] = nvim
local function define_signs(prefix)
  local error = (prefix .. "SignError")
  local warn = (prefix .. "SignWarn")
  local info = (prefix .. "SignInfo")
  local hint = (prefix .. "SignHint")
  vim.fn.sign_define(error, {text = "x", texthl = error})
  vim.fn.sign_define(warn, {text = "!", texthl = warn})
  vim.fn.sign_define(info, {text = "i", texthl = info})
  return vim.fn.sign_define(hint, {text = "?", texthl = hint})
end
_2amodule_2a["define-signs"] = define_signs
if (nvim.fn.has("nvim-0.6") == 1) then
  define_signs("Diagnostic")
else
  define_signs("LspDiagnostics")
end
local handlers = {["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {severity_sort = true, update_in_insert = false, underline = true, virtual_text = false}), ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "single"}), ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "single"})}
local capabilities = cmplsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach
local function _2_(client, bufnr)
  nvim.buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", {noremap = true})
  nvim.buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", {noremap = true})
  nvim.buf_set_keymap(bufnr, "n", "<leader>ld", "<Cmd>lua vim.lsp.buf.declaration()<CR>", {noremap = true})
  nvim.buf_set_keymap(bufnr, "n", "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", {noremap = true})
  nvim.buf_set_keymap(bufnr, "n", "<leader>lh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {noremap = true})
  nvim.buf_set_keymap(bufnr, "n", "<leader>ln", "<cmd>lua vim.lsp.buf.rename()<CR>", {noremap = true})
  nvim.buf_set_keymap(bufnr, "n", "<leader>le", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", {noremap = true})
  nvim.buf_set_keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", {noremap = true})
  nvim.buf_set_keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", {noremap = true})
  nvim.buf_set_keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", {noremap = true})
  nvim.buf_set_keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", {noremap = true})
  nvim.buf_set_keymap(bufnr, "n", "<leader>lo", ":lua require('telescope.builtin').lsp_document_symbols()<cr>", {noremap = true})
  nvim.buf_set_keymap(bufnr, "n", "<leader>la", ":lua require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_cursor())<cr>", {noremap = true})
  nvim.buf_set_keymap(bufnr, "v", "<leader>la", ":'<,'>:Telescope lsp_range_code_actions theme=cursor<cr>", {noremap = true})
  nvim.buf_set_keymap(bufnr, "n", "<leader>lw", ":lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>", {noremap = true})
  nvim.buf_set_keymap(bufnr, "n", "<leader>lr", ":lua require('telescope.builtin').lsp_references()<cr>", {noremap = true})
  return nvim.buf_set_keymap(bufnr, "n", "<leader>li", ":lua require('telescope.builtin').lsp_implementations()<cr>", {noremap = true})
end
on_attach = _2_
return lsp.clojure_lsp.setup({on_attach = on_attach, handlers = handlers, capabilities = capabilities})