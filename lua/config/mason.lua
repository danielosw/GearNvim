--[[
Mason configuration for managing LSP servers, DAP adapters, linters, and formatters.
This file sets up:
- Mason package manager
- Mason-nvim-dap for debug adapters
- LSP server initialization
- Navigation breadcrumbs
- Null-ls for additional diagnostics (mypy for Python)
]]

-- Initialize Mason package manager
require("mason").setup()

-- Setup Mason integration with nvim-dap for debugger adapters
require("mason-nvim-dap").setup()

local mason_lspconfig = require("mason-lspconfig")

-- Global Mason registry for package management
Mason_registry = require("mason-registry")

-- Load LSP configurations from lib/lspconfigs.lua
require("lib.lspconfigs")

-- Enable all installed LSP servers
local servers = mason_lspconfig.get_installed_servers()
for _, name in ipairs(servers) do
	vim.lsp.enable(name)
end

-- Explicitly enable rust_analyzer (may not be managed by Mason)
vim.lsp.enable("rust_analyzer")

-- Configure navigation breadcrumbs in the window bar
-- Shows current code context (function, class, etc.)
vim.o.winbar = "%{%v:lua.require('nvim-navic').get_location()%}"

-- Setup null-ls for additional diagnostics and formatting
local nls = require("null-ls")

-- Register mypy for Python type checking
-- Configured to use the project's Python executable (from venv or system)
nls.register(nls.builtins.diagnostics.mypy.with({
	extra_args = function()
		return {
			"--python-executable",
			PythonPath,  -- Use detected Python path from callonce.lua
		}
	end,
}))
