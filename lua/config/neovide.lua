local g = vim.g
local o = vim.o
g.neovide_theme = "auto"
g.neovide_no_idle = true
g.neovide_cursor_vfx_mode = "railgun"
if Windows then
	g.neovide_title_background_color =
		string.format("%x", vim.api.nvim_get_hl(0, { id = vim.api.nvim_get_hl_id_by_name("Normal") }).bg)
end

-- You can setup any custom logic for font's here
local function getFont()
	return "CaskaydiaCove NF:h11"
end

o.guifont = getFont()
