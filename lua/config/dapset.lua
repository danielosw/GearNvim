--[[
DAP (Debug Adapter Protocol) setup and configuration.
This file sets up debug adapters for various languages:
- Python (debugpy)
- C/C++/Rust (codelldb)
- TypeScript/JavaScript (firefox-debug-adapter)

Only sets up adapters that are actually installed to avoid errors.
]]

local dapui = require("dapui")
Dap = require("dap")

-- Auto-open DAP UI when debugging session starts
Dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

-- Configure a debug adapter by name
-- Only sets up if the adapter is installed to avoid crashes
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
				local catpath = RealPath("/venv/bin/python")
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
	elseif temp == "codelldb" then
		Dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = vim.fn.exepath("codelldb"),
				args = { "--port", "${port}" },
			},
		}
	elseif temp == "firefox-debug-adapter" then
		local catpath = RealPath("/dist/adapter.bundle.js")
		Dap.adapters.firefox = {
			type = "executable",
			command = "node",
			args = vim.fn.exepath("firefox-debug-adapter") .. catpath,
		}
	end
end
-- List of supported debug adapters
local daps = { "firefox-debug-adapter", "debugpy", "codelldb" }

-- Check if a debug adapter is installed and set it up
local function dapexists(dap)
	if vim.fn.executable(dap) then
		setupDap(dap)
	end
end

-- Iterate through all supported debug adapters and setup any that are installed
ForEach(daps, dapexists)
