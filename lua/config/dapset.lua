local Mason_registry = require("mason-registry")
local dapui = require("dapui")
Dap = require("dap")
Dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
-- Takes in a string and configs a matching dap.
-- The reason I do it this way is so it does not crash if a dap is not installed, because some of configs require it to be installed in mason.
local function setupDap(temp)
	if temp == "debugpy" then
		Dap.adapters.python = function(cb, config)
			if config.request == "attach" then
				local port = (config.connect or config).port
				local host = (config.connect or config).host or "127.0.0.1"
				cb({
					type = "server",
					port = assert(port, "connect.port is required for a python attach configuration"),
					host = host,
					options = {
						source_filetype = "python",
					},
				})
			else
				if Windows then
					catpath = "\\venv\\scripts\\python"
				else
					catpath = "/venv/bin/python"
				end
				cb({
					type = "executable",
					command = vim.fn.exepath("debugpy") .. catpath,
					args = { "-m", "debugpy.adapter" },
					options = {
						source_filetype = "python",
					},
				})
			end
		end
	end
	if temp == "codelldb" then
		Dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = vim.fn.exepath("codelldb"),
				args = { "--port", "${port}" },
			},
		}
	end
	if temp == "firefox-debug-adapter" then
		if Windows then
			catpath = "\\dist\\adapter.bundle.js"
		else
			catpath = "/dist/adapter.bundle.js"
		end
		Dap.adapters.firefox = {
			type = "executable",
			command = "node",
			args = vim.fn.exepath("firefox-debug-adapter") .. catpath,
		}
	end
end

-- Get a list of all installed daps and setup any found
ForEach(Daps, setupDap)
