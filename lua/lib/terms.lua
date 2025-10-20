--[[
Terminal-specific configuration settings.
This file contains theme and color settings that vary based on the terminal emulator being used.
]]

-- Global terminal configuration table
Termconf = {
	-- Dracula theme options
	draculaopts = {
		show_end_of_buffer = false,  -- Hide tilde characters at end of buffer
		transparent_bg = false,       -- Disable transparent background
		italic_comment = false,       -- Don't use italic for comments
		colors = {},                  -- Custom color overrides (empty = use defaults)
		overrides = {
			-- Ensure consistent backgrounds for window and tab bars
			WinBar = { bg = "bg" },      -- Active window bar background
			WinBarNC = { bg = "bg" },    -- Inactive window bar background
			TabLineSel = { bg = "bg" },  -- Selected tab background
		},
	},
}

-- Terminal-specific settings
if Term == "wezterm" and Windows then
	-- Enable true color support for WezTerm on Windows
	-- This is necessary because WezTerm on Windows may not advertise true color support correctly
	vim.o.termguicolors = true
end
