return {

	{ "folke/tokyonight.nvim", priority = 200 },
	{
		"Mofiqul/dracula.nvim",
		name = "dracula",
		priority = 200,
		opts = {
			show_end_of_buffer = false,
			transparent_bg = false,
			italic_comment = false,
			colors = {},
			overrides = {
				WinBar = { bg = "bg" },
				WinBarNC = { bg = "bg" },
				TabLineSel = { bg = "bg" },
			},
		},
	},
}
