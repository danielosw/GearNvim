---@param opts vim.api.keyset.user_command_args Command context metadata passed by Neovim
local function spacesToTabs(opts)
	---@type integer
	local bufnr = vim.api.nvim_get_current_buf()
	---@type integer
	local start_line = opts.range == 0 and 0 or (opts.line1 - 1)
	---@type integer
	local end_line = opts.range == 0 and -1 or opts.line2
	---@type string[]
	local lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line, false)
	---@type string[]
	local modified_lines = {}
	for i, line in ipairs(lines) do
		modified_lines[i] = line:gsub("^%s+", function(match)
			return match:gsub("    ", "\t")
		end)
	end
	vim.api.nvim_buf_set_lines(bufnr, start_line, end_line, false, modified_lines)
end
---@param opts vim.api.keyset.user_command_args Command context metadata passed by Neovim
local function tabsToSpaces(opts)
	---@type integer
	local bufnr = vim.api.nvim_get_current_buf()
	---@type integer
	local start_line = opts.range == 0 and 0 or (opts.line1 - 1)
	---@type integer
	local end_line = opts.range == 0 and -1 or opts.line2
	---@type string[]
	local lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line, false)
	---@type string[]
	local modified_lines = {}
	for i, line in ipairs(lines) do
		modified_lines[i] = line:gsub("^%s+", function(match)
			return match:gsub("\t", "    ")
		end)
	end
	vim.api.nvim_buf_set_lines(bufnr, start_line, end_line, false, modified_lines)
end

---@type vim.api.keyset.user_command
local command_opts1 = {
	range = true,
	desc = "Replaces leading groups of 4 spaces with tabs in the buffer or visual selection",
}
local command_opts2 = {
	range = true,
	desc = "Replaces leading groups of tabs with four spaces",
}

vim.api.nvim_create_user_command("SpacesToTabs", spacesToTabs, command_opts1)
vim.api.nvim_create_user_command("TabsToSpaces", tabsToSpaces, command_opts2)
