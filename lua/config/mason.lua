local mason = require("mason").setup()
require("mason-nvim-dap").setup()
require("mason-lspconfig").setup()
local masonconfig = require("mason-lspconfig")
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
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true)
	end
end
-- Not used in this file but is used in dapset
Daps = {}

-- loop through packages.
for _, pkg_info in ipairs(Mason_registry.get_installed_packages()) do
	-- Loop through the type assigned to the package.
	for _, type in ipairs(pkg_info.spec.categories) do
		-- Do things based on type.
		if type == "DAP" then
			Daps[#Daps + 1] = pkg_info.name
		elseif type == "LSP" then
			local lsp2 = masonconfig.get_mappings().package_to_lspconfig[pkg_info.name]
			-- We need to do special config for pylsp to disable plugins
			if lsp2 ~= "pylsp" then
				vim.lsp.config(lsp2, { on_attach = on_attach })
				vim.lsp.enable(lsp2, true)
				-- We want to let the user format with what they want so just disable everything except rope
			else
				vim.lsp.config(lsp2, {
					on_attach = function(client, bufnr)
						navic.attach(client, bufnr)
					end,
					settings = {
						["pylsp"] = {
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
					},
				})
				vim.lsp.enable(lsp2, true)
			end
		end
	end
end

-- setup fish-lsp
vim.lsp.config["fish_lsp"] = {}
vim.lsp.enable("fish_lsp")
-- setup ruff
ruffconfig = function()
	if Windows then
		return HOME .. "\\AppData\\Roaming\\ruff\\ruff.toml"
	else
		return HOME .. "/.config/ruff/ruff.toml"
	end
end
vim.lsp.config["ruff"] = {
	init_options = {
		settings = {
			configurationPreference = "filesystemFirst",
			configuration = ruffconfig(),
		},
	},
}
-- Define navic winbar.
vim.o.winbar = "%{%v:lua.require('nvim-navic').get_location()%}"
local nls = require("null-ls")
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
						PythonPath,
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
