local mason = require("mason").setup()
require("mason-nvim-dap").setup()
require("mason-lspconfig").setup()
local mason_lspconfig = require("mason-lspconfig")
Mason_registry = require("mason-registry")
local navic = require("nvim-navic")
local navbud = require("nvim-navbuddy")
local lspconfig = require("lspconfig")
-- lsp on attach
local on_attach = function(client, bufnr)
	-- navic
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
		navbud.attach(client, bufnr)
	end
	-- enable inlay hints if possible
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true)
	end
end

local servers = mason_lspconfig.get_installed_servers()
for i, name in ipairs(servers) do
	if name ~= "pylsp" then
		lspconfig[name].setup({
			on_attach = on_attach,
		})
	else
		lspconfig[name].setup({
			on_attach = on_attach,
			settings = {
				plugins = {
					autopep8 = {
						enabled = false,
					},
					mccabe = {
						enabled = false,
					},
					pycodestyle = {
						enabled = false,
					},
					pyflakes = {
						enabled = false,
					},
					yapf = {
						enabled = false,
					},
				},
			},
		})
	end
end

-- Define navic winbar.
vim.o.winbar = "%{%v:lua.require('nvim-navic').get_location()%}"
-- nls setup
local nls = require("null-ls")
nls.register(nls.builtins.diagnostics.mypy.with({
	extra_args = function()
		return {
			"--python-executable",
			PythonPath,
		}
	end,
}))
