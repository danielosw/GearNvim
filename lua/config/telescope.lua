--[[
Telescope custom pickers configuration.
This file defines custom telescope pickers, particularly:
- Theme picker: Interactive colorscheme selector with live preview
  Saves selected theme to lua/config/theme.lua for persistence
]]

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local previewers = require("telescope.previewers")

-- Get list of all available colorschemes
local schemes = function()
	-- get a list of all color schemes
	local themes = {}
	for _, value in pairs(vim.fn.getcompletion("", "color")) do
		themes[#themes + 1] = value
	end
	return themes
end

-- Custom theme picker with live preview
-- Allows selecting and previewing themes, then saves selection to config
Themepick = function(opts)
	local set = false
	-- Store current theme to restore if user cancels
	local before_background = vim.g.colors_name or "vim"
	local bufnr = vim.api.nvim_get_current_buf()
	local p = vim.api.nvim_buf_get_name(bufnr)
	opts = opts or {}
	pickers
		.new(opts, {
			prompt_title = "themes",
			finder = finders.new_table(schemes()),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, map)
				-- On selection (Enter key)
				actions.select_default:replace(function()
					set = true
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					-- Apply selected colorscheme
					vim.cmd("colorscheme " .. selection[1])
					-- Persist selection to theme.lua file
					local file = "dummy.lua"
					local folder = ConfigPath
					file = folder .. RealPath("/lua/config/theme.lua")
					local filehandle = io.open(file, "w+")
					if filehandle ~= nil then
						filehandle.write(filehandle, 'vim.cmd("colorscheme ' .. selection[1] .. '")')
					end
					-- Close file handle
					if filehandle ~= nil then
						filehandle.close(filehandle)
					end
				end)
				return true
			end,
			-- Live preview: Apply theme as user navigates
			previewer = previewers.new_buffer_previewer({
				define_preview = function(self, entry)
					-- Load current buffer content for preview
					if vim.loop.fs_stat(p) then
						conf.buffer_previewer_maker(p, self.state.bufnr, { bufname = self.state.bufname })
					else
						local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
						vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
					end
					-- Apply theme for preview (this is why we need to restore later)
					vim.cmd("colorscheme " .. entry[1])
				end,

				get_buffer_by_name = function()
					return p
				end,
				teardown = function(self)
					-- Restore original theme if user cancelled (didn't select)
					if not set then
						vim.cmd("colorscheme " .. before_background)
					end
				end,
			}),
		})
		:find()
end

-- to execute the function
