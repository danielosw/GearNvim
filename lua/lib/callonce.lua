Cwd = vim.fn.getcwd()
local execute = vim.fn.executable
--- @return boolean
local function Iswindows()
	if package.config:sub(1, 1) == "\\" then
		return true
	else
		return false
	end
end
local Windows = Iswindows()
-- Source - https://stackoverflow.com/q/2282444
-- Posted by Wookai, modified by community. See post 'Timeline' for change history
-- Retrieved 2026-04-08, License - CC BY-SA 2.5
function table.contains(table, element)
	for _, value in pairs(table) do
		if value == element then
			return true
		end
	end
	return false
end
local function getPython()
	do
		if not Windows then
			if execute(Cwd .. "/.venv/bin/python") == 1 then
				return Cwd .. "/.venv/bin/python"
			end
		else
			if execute(Cwd .. "\\.venv\\Scripts\\python.exe") == 1 then
				return Cwd .. "\\.venv\\Scripts\\python.exe"
			end
		end
		return vim.fn.exepath("python")
	end
end
--- @param path string
--- @return string
function RealPath(path)
	if Windows then
		-- convert unix to windows
		-- this *may* break some weird paths but hopefully that won't happen
		return path:gsub("/", "\\")
	end
	return path
end

--- @param iter table
--- @param func function
--- @return table
function Map(iter, func)
	do
		local toReturn = {}
		for _, value in ipairs(iter) do
			toReturn[#toReturn + 1] = func(value)
		end
		return toReturn
	end
end

--- @param iter table
--- @param func function
--- @return nil
function ForEach(iter, func)
	do
		for _, value in ipairs(iter) do
			func(value)
		end
	end
end

Globals = {
	Windows = Windows,
	Home = vim.env.HOME,
	Term = vim.env.TERM,
	PythonPath = getPython(),
	ConfigPath = vim.fn.stdpath("config"),
	DataPath = vim.fn.stdpath("data"),
}

