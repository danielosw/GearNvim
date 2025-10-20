--[[
This file configures Debug Adapter Protocol (DAP) settings for various programming languages.
It sets up debugger configurations for C, C++, Rust, Python, and TypeScript.
This file is loaded to initialize debugging capabilities for supported file types.
]]

-- Get the current file type
local ft = vim.o.ft

-- Shared codelldb configuration for C, C++, and Rust
-- codelldb is a LLDB-based debugger for native languages
local codelldb_config = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", Cwd .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}

-- Configure debugger based on file type
if ft == "cpp" or ft == "c" or ft == "rust" then
	-- Use codelldb for C, C++, and Rust
	Dap.configurations[ft] = codelldb_config
elseif ft == "python" then
	-- Python debugging configuration using debugpy
	Dap.configurations.python = {
		{
			-- The first three options are required by nvim-dap
			type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
			request = "launch",
			name = "Launch file",

			-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

			program = "${file}", -- This configuration will launch the current file if used.
			pythonPath = PythonPath,
			-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
			-- The code below looks for a `venv` or `.venv` folder in the current directory and uses the python within.
			-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
		},
	}
elseif ft == "typescript" then
	-- TypeScript/JavaScript debugging configuration using Firefox debugger
	Dap.configurations.typescript = {
		{
			name = "Debug with Firefox",
			type = "firefox",
			request = "launch",
			reAttach = true,
			url = "http://localhost:3000",
			webRoot = "${workspaceFolder}",
			firefoxExecutable = function()
				if Windows then
					-- Not yet tested
					return vim.fn.exepath("firefox")
				else
					return "/usr/bin/firefox"
				end
			end,
		},
	}
end
