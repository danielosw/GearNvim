local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local previewers = require("telescope.previewers")
-- get colorschemes
local schemes = function()
	local themes = {}
	for _, value in pairs(vim.fn.getcompletion("", "color")) do
		themes[#themes + 1] = value
	end
	return themes
end

local themepick = function(opts)
	local set = false
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
				actions.select_default:replace(function()
					set = true
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
					-- close file
					if filehandle ~= nil then
						filehandle.close(filehandle)
					end
				end)
				return true
			end,
			previewer = previewers.new_buffer_previewer({
				define_preview = function(self, entry)
					if vim.loop.fs_stat(p) then
						conf.buffer_previewer_maker(p, self.state.bufnr, { bufname = self.state.bufname })
					else
						local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
						vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
					end

					vim.cmd("colorscheme " .. entry[1])
				end,

				get_buffer_by_name = function()
					return p
				end,
				teardown = function(self)
					if not set then
						vim.cmd("colorscheme " .. before_background)
					end
				end,
			}),
		})
		:find()
end

-- to execute the function
vim.api.nvim_create_user_command("Themes", themepick, { desc = "theme picker" })
