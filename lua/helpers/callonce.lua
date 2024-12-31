Cwd = vim.fn.getcwd()

local function getPython()
	do
		if vim.uv.fs_stat(Cwd .. "/.venv/bin/python") == 1 then
			return Cwd .. "/.venv/bin/python"
		elseif vim.uv.fs_stat(Cwd .. "/venv/bin/python") == 1 then
			return Cwd .. "/venv/bin/python"
		elseif vim.uv.fs_stat(Cwd .. "\\.venv\\Scripts\\python.exe") == 1 then
			return Cwd .. "\\.venv\\Scripts\\python.exe"
		elseif vim.uv.fs_stat(Cwd .. "\\.venv\\Scripts\\python.exe") == 1 then
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
