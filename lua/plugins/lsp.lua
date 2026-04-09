return {
	{ "neovim/nvim-lspconfig" },
	{
		"folke/lazydev.nvim",
		name = "lazydev",
		opts = {
			library = {
				"lazy.nvim",
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				"lush.nvim",
			},
		},
	},

	{
		"aznhe21/actions-preview.nvim",
		config = function()
			vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
		end,
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		priority = 1000,
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
