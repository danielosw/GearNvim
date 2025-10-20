return {
	{ "nvimtools/none-ls.nvim", event = { "BufReadPre", "BufNewFile" } },
	{ "jay-babu/mason-null-ls.nvim", event = { "BufReadPre", "BufNewFile" } },
	{ "neovim/nvim-lspconfig", event = { "BufReadPre", "BufNewFile" } },
	{ "williamboman/mason.nvim", lazy = true },
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
	{ "williamboman/mason-lspconfig.nvim", event = { "BufReadPre", "BufNewFile" } },
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
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		opts = {},
	},
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
}
