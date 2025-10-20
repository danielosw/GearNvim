--[[
Language Server Protocol (LSP) plugin definitions.
This file configures LSP-related plugins including:
- null-ls for additional linters and formatters
- Mason for LSP/DAP/linter/formatter management
- LSP configuration and setup
- Navigation and code action enhancements
]]

return {
	-- null-ls: Use Neovim as a language server for linters/formatters
	{ "nvimtools/none-ls.nvim", event = { "BufReadPre", "BufNewFile" } },
	
	-- Mason integration with null-ls
	{ "jay-babu/mason-null-ls.nvim", event = { "BufReadPre", "BufNewFile" } },
	
	-- Core LSP configuration
	{ "neovim/nvim-lspconfig", event = { "BufReadPre", "BufNewFile" } },
	
	-- Mason: Package manager for LSP servers, DAP servers, linters, and formatters
	{ "williamboman/mason.nvim", lazy = true },
	
	-- LazyDev: Better Lua development with Neovim API completions
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				"lazy.nvim",
				"mason.nvim",
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				"lush.nvim",
			},
		},
	},
	-- Mason integration with LSP config
	{ "williamboman/mason-lspconfig.nvim", event = { "BufReadPre", "BufNewFile" } },
	
	-- Show lightbulb icon when code actions are available
	{
		"kosayoda/nvim-lightbulb",
		opts = {
			autocmd = { enabled = true },
			ignore = {
				clients = { "ruff" },
			},
		},
		event = { "LspAttach" },
	},
	-- Preview code actions in a floating window
	{
		"aznhe21/actions-preview.nvim",
		config = function()
			vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
		end,
		event = { "LspAttach" },
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy", -- Or `LspAttach`
		priority = 1000, -- needs to be loaded in first
		config = function()
			require("tiny-inline-diagnostic").setup({
				options = {
					show_source = { enabled = true },
					multilines = {
						enabled = true,
					},
					use_icons_from_diagnostic = true,
					show_all_diags_on_cursorline = true,
				},
			})
			vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
		end,
	},
}
