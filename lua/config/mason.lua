mason = require("mason").setup()
require("mason-nvim-dap").setup()
require("mason-lspconfig").setup()
Linters = {}
Formatters = {}
local lspconfig = require("lspconfig")
local lspservers = {}
local masonconfig = require("mason-lspconfig")
Mason_registry = require("mason-registry")
local navic = require("nvim-navic")
local navbud = require("nvim-navbuddy")

local on_attach = function(client, bufnr)
	-- navic
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
		navbud.attach(client, bufnr)
	end
end
-- loop through packages.
for _, pkg_info in ipairs(Mason_registry.get_installed_packages()) do
	-- Loop through the type assigned to the package.
	for _, type in ipairs(pkg_info.spec.categories) do
		-- Do things based on type.
		if type == "Linter" then
			Linters[#Linters + 1] = pkg_info.name
		elseif type == "Formatter" then
			Formatters[#Linters + 1] = pkg_info.name
		elseif type == "LSP" then
			lsp = masonconfig.get_mappings().mason_to_lspconfig[pkg_info.name]
			lspconfig[lsp].setup({ on_attach = on_attach })
		end
	end
end

-- setup gdscript lsp
if vim.fn.exepath("godot") ~= "" then
	require("lspconfig").gdscript.setup({})
end
-- setup fish-lsp
if vim.fn.exepath("fish-lsp") ~= "" then
	require("lspconfig").fish_lsp.setup({})
end
-- setup ruff
ruffconfig = function()
	if Iswindows() then
		return vim.env.HOME .. "\\AppData\\Roaming\\ruff\\ruff.toml"
	else
		return vim.env.HOME .. "/.config/ruff/ruff.toml"
	end
end
if vim.fn.exepath("ruff") ~= "" then
	require("lspconfig").ruff.setup({
		init_options = {
			settings = {
				configurationPreference = "filesystemFirst",
				configuration = ruffconfig(),
			},
		},
	})
end
-- Define navic winbar.
vim.o.winbar = "%{%v:lua.require('nvim-navic').get_location()%}"
nls = require("null-ls")
function getvenv()
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
end
-- Setup none-ls
require("mason-null-ls").setup({
	automatic_installation = false,
	handlers = {
		-- Change mypy to reference a venv.
		mypy = function(source_name, methods)
			nls.register(nls.builtins.diagnostics.mypy.with({
				extra_args = function()
					return {
						"--python-executable",
						getvenv(),
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
