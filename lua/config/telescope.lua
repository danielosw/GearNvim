local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local previewers = require("telescope.previewers")
local Previewer = require("telescope.previewers.previewer")
-- get colorschemes
local schemes = function()
	local themes = {}
	for _, value in pairs(vim.fn.getcompletion("", "color")) do
		themes[#themes + 1] = value
	end
	return themes
end

local themepick = function(opts)
	opts = opts or {}
	pickers
		.new(opts, {
			prompt_title = "themes",
			finder = finders.new_table(schemes()),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					-- set colorscheme now
					vim.cmd("colorscheme " .. selection[1])
					-- write scheme to file
					local file = "dummy.lua"
					local folder = vim.fn.stdpath("config")
					if Windows then
						file = folder .. "\\lua\\config\\theme.lua"
					else
						file = folder .. "/lua/config/theme.lua"
					end
					local filehandle = io.open(file, "w+")
					if filehandle ~= nil then
						filehandle.write(filehandle, 'vim.cmd("colorscheme ' .. selection[1] .. '")')
					end
				end)
				return true
			end,
		})
		:find()
end

-- to execute the function
vim.api.nvim_create_user_command("Themes", themepick, { desc = "theme picker" })
