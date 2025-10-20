--[[
Neovide-specific configuration.
This file is only loaded when running Neovim in the Neovide GUI.
Configures:
- Theme settings
- Cursor visual effects
- Font configuration
- Platform-specific title bar color (Windows)
]]

local g = vim.g
local o = vim.o

-- Neovide GUI settings
g.neovide_theme = "auto"              -- Auto-detect light/dark theme
g.neovide_no_idle = true              -- Keep rendering even when idle
g.neovide_cursor_vfx_mode = "railgun" -- Cursor animation effect

-- Windows-specific: Match title bar color to Neovim background
if Windows then
	g.neovide_title_background_color =
		string.format("%x", vim.api.nvim_get_hl(0, { id = vim.api.nvim_get_hl_id_by_name("Normal") }).bg)
end

-- Font configuration for Neovide
-- Customize this function to change the font
local function getFont()
	return "CaskaydiaCove NF:h11"
end

o.guifont = getFont()
