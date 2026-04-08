return {
	{
		"nvim-lualine/lualine.nvim",
		name = "lualine",
		opts = {
			theme = "auto",
			extensions = { "nvim-tree", "lazy" },
		},
	},
	{
		name = "noice",
		"folke/noice.nvim",
		opts = {},
	},
	{ "MunifTanjim/nui.nvim" },
	{ "rcarriga/nvim-notify" },
	{
		"akinsho/bufferline.nvim",
		name = "bufferline",
		opts = {
			options = {
				separator_style = "slant",
				themable = true,
			},
		},
	},
	{ "nvim-tree/nvim-web-devicons" },
	{
		"rachartier/tiny-devicons-auto-colors.nvim",
		name = "tiny-devicons-auto-colors",
		opts = {},
	},

	{
		"goolord/alpha-nvim",
	},
	{
		"SmiteshP/nvim-navic",
		name = "nvim-navic",
		opts = {
			lsp = {
				auto_attach = false,
				preference = nil,
			},
			highlight = true,
			separator = " > ",
			depth_limit = 10,
			depth_limit_indicator = "..",
			click = true,
		},
	},
	{
		"SmiteshP/nvim-navbuddy",
	},
	{
		"folke/snacks.nvim",
		name = "snacks",
		---@type snacks.Config
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			bigfile = { enabled = true },
			dashboard = { enabled = false },
			explorer = { enabled = false },
			indent = { enabled = false },
			input = { enabled = true },
			picker = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = not vim.g.neovide },
			statuscolumn = { enabled = false },
			words = { enabled = true },
			image = { enabled = true },
			lazygit = { enabled = true },
			git = { enabled = true },
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		name = "nvim-tree",
		opts = { hijack_unnamed_buffer_when_opening = true, hijack_netrw = true },
	},
}
