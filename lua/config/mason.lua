local mason = require("mason").setup()
require("mason-nvim-dap").setup()
require("mason-lspconfig").setup()
local mason_lspconfig = require("mason-lspconfig")
Mason_registry = require("mason-registry")
local navic = require("nvim-navic")
local navbud = require("nvim-navbuddy")
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
vim.lsp.config("*", { on_attach = on_attach })
local servers = mason_lspconfig.get_installed_servers()
for i, name in ipairs(servers) do
	if name ~= "pylsp" and name ~= "rust_analyzer" then
		vim.lsp.enable(name)
	elseif name == "pylsp" then
		vim.lsp.config(name, {
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
		vim.lsp.enable(name)
	end
end
vim.lsp.config("rust_analyzer", {
	on_attach = on_attach,
	settings = {
		["rust-analyzer"] = {
			checkOnSave = {
				command = "clippy",
			},
		},
	},
})
vim.lsp.enable("rust_analyzer")
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
