return {
	-- LSP servers and clients communicate which features they support through "capabilities".
	--  By default, Neovim supports a subset of the LSP specification.
	--  With blink.cmp, Neovim has *more* capabilities which are communicated to the LSP servers.
	--  Explanation from TJ: https://youtu.be/m8C0Cq9Uv9o?t=1275
	--
	-- This can vary by config, but in general for nvim-lspconfig:

	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
	},
	"nvimtools/none-ls.nvim",
	"jay-babu/mason-null-ls.nvim",
	"williamboman/mason-lspconfig.nvim",
	{
		"danielosw/nvim-lightbulb",
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
		event = { "LspAttach" },
		priority = 1000,
		opts = {
			hi = {
				error = "DiagnosticError",
				warn = "DiagnosticWarn",
				info = "DiagnosticInfo",
				hint = "DiagnosticHint",
				arrow = "NonText",
			},
			options = {
				-- Show the source of the diagnostic.
				show_source = true,

				-- Use your defined signs in the diagnostic config table.
				use_icons_from_diagnostic = true,
				-- Enable diagnostic message on all lines.
				multilines = true,

				-- Show all diagnostics on the cursor line.
				show_all_diags_on_cursorline = false,
			},
		},
	},
}
