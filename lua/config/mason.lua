mason = require("mason").setup()
require("mason-nvim-dap").setup()
require("mason-lspconfig").setup()
Linters = {}
local lspconfig = require("lspconfig")
local lspservers = {}
local masonconfig = require("mason-lspconfig")
Mason_registry = require("mason-registry")
local navic = require('nvim-navic')
local on_attach = function(client, bufnr)
    -- navic
    navic.attach(client, bufnr)

end
for _, pkg_info in ipairs(Mason_registry.get_installed_packages()) do
	for _, type in ipairs(pkg_info.spec.categories) do
		if type == "Linter" then
			Linters[#Linters + 1] = pkg_info.name
		elseif type == "LSP" then
			lsp = masonconfig.get_mappings().mason_to_lspconfig[pkg_info.name]
			lspconfig[lsp].setup{on_attach = on_attach}
		end
	end
end
vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
nls = require("null-ls")
require("mason-null-ls").setup({
	automatic_installation = false,
	handlers = {
		mypy = function(source_name, methods)
			nls.register(nls.builtins.diagnostics.mypy.with({
				extra_args = function()
					return {
						"--python-executable",
						function()
							local cwd = vim.fn.getcwd()
							if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
								return cwd .. "/venv/bin/python"
							elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
								return cwd .. "/.venv/bin/python"
							elseif vim.fn.executable(cwd .. "\\venv\\Scripts\\python.exe") == 1 then
								return cwd .. "\\venv\\Scripts\\python.exe"
							elseif vim.fn.executable(cwd .. "\\.venv\\Scripts\\python.exe") == 1 then
								return cwd .. "\\.venv\\Scripts\\python.exe"
							else
								return vim.fn.exepath("python")
							end
						end,
					}
				end,
			}))
		end,
	},
})

require("null-ls").setup({
	sources = {
		-- Anything not supported by mason.
	},
})
