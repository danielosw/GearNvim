-- the checkhealth for treesitter is broken on windows
local getchecks = function()
	local checks = {}
	for _, value in pairs(vim.fn.getcompletion("", "checkhealth")) do
		if value ~= "nvim-treesitter" and value ~= "vim.treesitter" then
			checks[#checks + 1] = value
		end
	end
	return checks
end
local wincheck = function()
	local checks = getchecks()
	local checkcmd = "checkhealth " .. table.concat(checks, " ")
	vim.cmd(checkcmd)
end

vim.api.nvim_create_user_command("Wincheck", wincheck, { desc = "windows checkhealth" })
