local mason = require("mason").setup()
require("mason-nvim-dap").setup()
require("mason-lspconfig").setup()
local mason_lspconfig = require("mason-lspconfig")
Mason_registry = require("mason-registry")
-- setup lsp configs
require("lib.lspconfigs")
local servers = mason_lspconfig.get_installed_servers()
for i, name in ipairs(servers) do
	vim.lsp.enable(name)
end

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
