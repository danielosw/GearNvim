Cwd = vim.fn.getcwd()
local execute = vim.fn.executable
local function getPython()
	do
		if execute(Cwd .. "/.venv/bin/python") == 1 then
			return Cwd .. "/.venv/bin/python"
		elseif execute(Cwd .. "/venv/bin/python") == 1 then
			return Cwd .. "/venv/bin/python"
		elseif execute(Cwd .. "\\.venv\\Scripts\\python.exe") == 1 then
			return Cwd .. "\\.venv\\Scripts\\python.exe"
		elseif execute(Cwd .. "\\.venv\\Scripts\\python.exe") == 1 then
			return Cwd .. "\\.venv\\Scripts\\python.exe"
		else
			return vim.fn.exepath("python")
		end
	end
end

local function Iswindows()
	if package.config:sub(1, 1) == "\\" then
		return true
	else
		return false
	end
end
HOME = vim.env.HOME
ConfigPath = vim.fn.stdpath("config")
Term = vim.env.TERM
Windows = Iswindows()
PythonPath = getPython()
NVscode = vim.g.vscode ~= 1
