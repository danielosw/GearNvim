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
				"nvim-dap",
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				"lush.nvim",
			},
		},
	},
	{ "williamboman/mason-lspconfig.nvim", opts = { automatic_enable = false }, event = { "BufReadPre", "BufNewFile" } },
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
}
