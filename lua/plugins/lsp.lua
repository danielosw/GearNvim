return {
	"nvimtools/none-ls.nvim",
	"jay-babu/mason-null-ls.nvim",
	"neovim/nvim-lspconfig",
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
				{ path = "wezterm-types", mods = { "wezterm" } },
			},
		},
	},
	{ "justinsgithub/wezterm-types", ft = "lua" },
	{
		"stevearc/overseer.nvim",
		opts = { templates = { "builtin" } },
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "OverseerInfo" },
	},
	{ "williamboman/mason-lspconfig.nvim", opts = { automatic_enable = false } },
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
