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

-- ghostty has a slightly different dracula scheme so I do this to make it match
if Term == "xterm-ghostty" then
	Termconf.draculaopts.overrides.Normal = { bg = "#21222C" }
elseif Term == "wezterm" and Windows then
	-- just for windows
	vim.o.termguicolors = true
end
