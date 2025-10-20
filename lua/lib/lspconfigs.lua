--[[
Language Server Protocol (LSP) configuration for various programming languages.
This file sets up LSP servers with custom settings and capabilities like:
- Navigation breadcrumbs (navic)
- Navigation buddy for symbol navigation
- Inlay hints
- Code lens
- Language-specific settings for Rust, Python, and Lua
]]

local navic = require("nvim-navic")
local navbud = require("nvim-navbuddy")

-- LSP on_attach callback function
-- Called when an LSP client attaches to a buffer
-- Sets up features like navigation, inlay hints, and code lens
local on_attach = function(client, bufnr)
	-- Attach navigation breadcrumbs if server supports document symbols
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)   -- Enable breadcrumb navigation bar
		navbud.attach(client, bufnr)  -- Enable symbol navigation popup
	end
	
	-- Enable inlay hints if supported (shows type hints inline)
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true)
	end
	
	-- Setup code lens auto-refresh if supported and enabled globally
	-- Code lens shows actionable metadata like test counts, references, etc.
	if client.supports_method("textDocument/codeLens") and Codelens then
		vim.lsp.codelens.refresh()

		-- Auto-refresh code lens on buffer enter and insert leave
		vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {

			buffer = bufnr,

			callback = vim.lsp.codelens.refresh,
		})
	end
end

-- Apply on_attach callback to all LSP servers
vim.lsp.config("*", { on_attach = on_attach })

-- Rust Analyzer configuration with enhanced features
vim.lsp.config("rust_analyzer", {
	on_attach = on_attach,
	settings = {
		["rust-analyzer"] = {
			checkOnSave = {
				command = "clippy",
			},
			lens = {
				enable = true,
			},
			completion = {
				fullFunctionSignatures = {
					enable = true,
				},
			},
			inlayHints = {
				closureReturnTypeHints = {
					enable = true,
				},
			},
			semanticHighlighting = {
				operator = {
					specialization = {
						enable = true,
					},
				},
			},
			procMacro = {
				enable = true,
			},
		},
	},
})
-- Python LSP (pylsp) configuration
-- Disables most plugins to avoid conflicts with external formatters/linters
vim.lsp.config("pylsp", {
	on_attach = on_attach,
	settings = {
		-- disable all plugins but rope
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
-- Lua Language Server configuration
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			codeLens = {
				enable = true,
			},
		},
	},
})
