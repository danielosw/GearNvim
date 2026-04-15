return {
	{ "nvim-mini/mini.pairs", version = "*", name = "mini.pairs", opts = {} },
	{
		"saecki/crates.nvim",
		name = "crates",
		opts = {},
	},
	{
		"chrisgrieser/nvim-rip-substitute",
	},
	{
		"stevearc/conform.nvim",
		name = "conform",
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
		config = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
	-- comment out neorg till tree sitter is fixed
}
