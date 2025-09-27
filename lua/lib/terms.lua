Termconf = {
	draculaopts = {
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
}

if Term == "wezterm" and Windows then
	-- just for windows
	vim.o.termguicolors = true
end
