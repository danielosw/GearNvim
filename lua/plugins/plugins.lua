--[[
General plugins configuration.
This file defines various utility plugins for Neovim including:
- Auto-pairing brackets and quotes
- Rust crate management
- Text substitution utilities
- Snippet management
- File navigation and search
]]

return {
	-- Automatically insert closing brackets, quotes, etc.
	{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },
	-- Rust crate version management and information
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		opts = {},
	},
	-- Fast text substitution using ripgrep
	{
		"chrisgrieser/nvim-rip-substitute",
		cmd = "RipSubstitute",
		opts = {},
		keys = {
			{
				"<leader>fs",
				function()
					require("rip-substitute").sub()
				end,
				mode = { "n", "x" },
				desc = " rip substitute",
			},
		},
	},
	-- Snippet editing and management
	{
		"chrisgrieser/nvim-scissors",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = {
			{
				"<leader>se",
				function()
					require("scissors").editSnippet()
				end,
				mode = { "n" },
				desc = "Snippet: Edit",
			},
			{
				"<leader>sa",
				function()
					require("scissors").addNewSnippet()
				end,
				mode = { "n", "x" },
				desc = "Snippet: Add",
			},
		},
		opts = {

			snippetDir = ConfigPath .. "/snippets",
		},
	},
	-- Code formatting plugin
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>f",
				function()
					require("conform").format({ async = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		-- This will provide type hinting with LuaLS
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			-- Define your formatters
			-- Set default options
			default_format_opts = {
				lsp_format = "fallback",
			},
			-- Set up format-on-save
			format_on_save = { timeout_ms = 500 },
			-- Customize formatters
			formatters = {
				shfmt = {
					prepend_args = { "-i", "2" },
				},
			},
		},
		init = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
	-- comment out neorg till tree sitter is fixed
}
