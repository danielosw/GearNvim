--- Compatability layer for lazy
--- Does not work on everything but its something
---@class pluginManager
---@field pluginsetup function
local M = {}
---@param x string
---@return string
local gh = function(x)
	return "https://github.com/" .. x
end
---@param pluginstable table
local function setDefaults(pluginstable)
	local plugspecs = pluginstable
	for _, p in ipairs(plugspecs) do
		p.priority = (p.priority ~= nil) and p.priority or 50
		p.name = p.name or p[1]
	end
	return plugspecs
end

---@param plugspecs table
---@return table
local function tablesort(plugspecs)
	local ps = plugspecs
	table.sort(ps, function(p1, p2)
		if p1.deps ~= nil then
			if table.contains(p1.deps, p2[1]) then
				return false
			end
		end
		if p2.deps ~= nil then
			if table.contains(p2.deps, p1[1]) then
				return true
			end
		end
		return p1.priority > p2.priority
	end)
	return ps
end
local function callback(value)
	local name = value.name
	if value.version ~= nil then
		vim.pack.add({ { src = gh(value[1]), versioning = vim.version.range(value.version), name = name } })
	else
		vim.pack.add({ { src = gh(value[1]), name = name } })
	end

	if value.opts ~= nil then
		require(value.name).setup(value.opts)
	end
	if value.config ~= nil then
		value.config()
	end
end
---@param pluginspecs table
local function setup(pluginspecs)
	for _, value in ipairs(pluginspecs) do
		local event = value.event
		-- verylazy just means load at start
		if event == nil or event == "VeryLazy" then
			callback(value)
		else
			for _, i in ipairs(event) do
				-- pass the value to the callback function using a closure

				vim.api.nvim_create_autocmd(i, {
					callback = function()
						callback(value)
					end,
					once = true,
				})
			end
		end
	end
end
---@param plugin_file_list table
---@return nil
---takes a list of plugins and sets them up
M.pluginsetup = function(plugin_file_list)
	local tomerge = Map(plugin_file_list, function(plug_name)
		return require("plugins/" .. plug_name)
	end)
	local merge = function(tables)
		local merger = {}
		for _, i in ipairs(tables) do
			for _, p in ipairs(i) do
				table.insert(merger, p)
			end
		end
		return merger
	end
	local merged = setDefaults(merge(tomerge))

	local ptable = tablesort(merged)
	setup(ptable)
end

vim.api.nvim_create_user_command("PluginUpdate", function()
	vim.pack.update()
end, { desc = "Update Plugins" })
vim.api.nvim_create_user_command("PluginClean", function()
	local inactive = vim.iter(vim.pack.get())
		:filter(function(x)
			return not x.active
		end)
		:map(function(x)
			return x.spec.name
		end)
		:totable()
	vim.pack.del(inactive)
end, { desc = "Remove unused plugins" })

vim.api.nvim_create_user_command("PluginShow", function()
	vim.pack.update(nil, { offline = true })
end, { desc = "Show installed plugins" })

return M
