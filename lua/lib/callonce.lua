--[[
This file defines global utility functions and variables that are called once on startup.
It provides platform-specific path helpers, Python path detection, and common functional
programming utilities.
]]

-- Store current working directory
Cwd = vim.fn.getcwd()
local execute = vim.fn.executable

-- Detect Python executable path
-- Searches for virtual environment Python first, then falls back to system Python
local function getPython()
	do
		if not Windows then
			-- Unix-like systems: check for .venv or venv directories
			if execute(Cwd .. "/.venv/bin/python") == 1 then
				return Cwd .. "/.venv/bin/python"
			elseif execute(Cwd .. "/venv/bin/python") == 1 then
				return Cwd .. "/venv/bin/python"
			end
		else
			-- Windows: check for .venv or venv directories with Windows paths
			if execute(Cwd .. "\\.venv\\Scripts\\python.exe") == 1 then
				return Cwd .. "\\.venv\\Scripts\\python.exe"
			elseif execute(Cwd .. "\\.venv\\Scripts\\python.exe") == 1 then
				return Cwd .. "\\.venv\\Scripts\\python.exe"
			end
		end
		-- Fallback to system Python
		return vim.fn.exepath("python")
	end
end

-- Detect if running on Windows by checking path separator
local function Iswindows()
	if package.config:sub(1, 1) == "\\" then
		return true
	else
		return false
	end
end

-- Convert Unix-style paths to Windows-style paths when on Windows
-- Converts forward slashes to backslashes for Windows compatibility
function RealPath(path)
	if Windows then
		-- convert unix to windows
		-- this *may* break some weird paths but hopefully that won't happen
		return path:gsub("/", "\\")
	end
	return path
end

-- Map function: applies a function to each element in an iterable
-- Returns a new table with the transformed values
function Map(iter, func)
	do
		local toReturn = {}
		for _, value in ipairs(iter) do
			toReturn[#toReturn + 1] = func(value)
		end
		return toReturn
	end
end

-- ForEach function: applies a function to each element in an iterable
-- Does not return anything, used for side effects
function ForEach(iter, func)
	do
		for _, value in ipairs(iter) do
			func(value)
		end
	end
end

-- Global variables used throughout the configuration
HOME = vim.env.HOME          -- User home directory
Term = vim.env.TERM          -- Terminal type (e.g., wezterm, xterm, etc.)
Windows = Iswindows()        -- Boolean flag for Windows platform detection
PythonPath = getPython()     -- Path to Python executable (venv or system)
ConfigPath = vim.fn.stdpath("config")  -- Neovim config directory
DataPath = vim.fn.stdpath("data")      -- Neovim data directory
