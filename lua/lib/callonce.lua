Cwd = vim.fn.getcwd()
local execute = vim.fn.executable
local function getPython()
	do
		if Windows then
			if execute(Cwd .. "/.venv/bin/python") == 1 then
				return Cwd .. "/.venv/bin/python"
			elseif execute(Cwd .. "/venv/bin/python") == 1 then
				return Cwd .. "/venv/bin/python"
			end
		else
			if execute(Cwd .. "\\.venv\\Scripts\\python.exe") == 1 then
				return Cwd .. "\\.venv\\Scripts\\python.exe"
			elseif execute(Cwd .. "\\.venv\\Scripts\\python.exe") == 1 then
				return Cwd .. "\\.venv\\Scripts\\python.exe"
			end
		end
		return vim.fn.exepath("python")
	end
end

local function Iswindows()
	if package.config:sub(1, 1) == "\\" then
		return true
	else
		return false
	end
end
function RealPath(path)
	if Windows then
		-- convert unix to windons
		-- this *may* break some weird paths but hopefully that won't happen
		return path:gsub("/", "\\")
	end
	return path
end
function Map(iter, func)
	do
		local toReturn = {}
		for _, value in ipairs(iter) do
			toReturn[#toReturn + 1] = func(value)
		end
		return toReturn
	end
end
function ForEach(iter, func)
	do
		for _, value in ipairs(iter) do
			func(value)
		end
	end
end

HOME = vim.env.HOME
Term = vim.env.TERM
Windows = Iswindows()
PythonPath = getPython()
ConfigPath = vim.fn.stdpath("config")
DataPath = vim.fn.stdpath("data")
