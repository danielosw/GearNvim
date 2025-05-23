local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
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
		})
		:find()
end

-- to execute the function
vim.api.nvim_create_user_command("Themes", themepick, { desc = "theme picker" })
