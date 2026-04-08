--- Set globals
Globals = {
	Windows = package.config:sub(1, 1) == "\\",
}
---@class QuotesConfig
---@field inspire boolean
---@field comedy boolean
---@field other boolean

---@class ConfigTable
---@field quotes QuotesConfig
---@field codeLens boolean
---@type ConfigTable
Settings = {
	quotes = {
		inspire = true,
		comedy = true,
		other = true,
	},
	codeLens = true,
}
-- create convinance locals
local windows = Globals.Windows
local g = vim.g
local opt = vim.opt
local o = vim.o
if windows ~= true then
	o.clipboard = "unnamedplus"
else
	o.clipboard = "unnamed"
end
-- set leader key to ,
g.mapleader = ","
g.maplocalleader = ","
-- disable netrw because we are using NvimTree
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
-- disable this if you use a terminal that does not support it
opt.termguicolors = true
-- Disabling default style's because I don't like them
g.python_recommended_style = 0
g.rust_recommended_style = 0
-- Enabling tabs and setting their size
opt.expandtab = false
o.tabstop = 4
o.shiftwidth = 4
o.number = true
-- load plugins
local gh = function(x)
	return "https://github.com/" .. x
end
local function pluginget(plugintable)
	local pluglist = {}
	for _, table in ipairs(plugintable) do
		vim.list_extend(pluglist, table)
	end
	return pluglist
end
-- setup autocmds
---@param ev vim.api.keyset.events
local hooks = function(ev)
	local name, kind = ev.data.spec.name, ev.data.kind
	if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
		vim.system({
			"cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		}, { cwd = ev.data.path }):wait()
	elseif name == "blink.cmp" and (kind == "install" or kind == "update") then
		vim.notify("Building blink.cmp", vim.log.levels.INFO)
		local obj = vim.system({ "cargo", "build", "--release" }, { cwd = ev.data.path }):wait()
		if obj.code == 0 then
			vim.notify("Building blink.cmp done", vim.log.levels.INFO)
		else
			vim.notify("Building blink.cmp failed", vim.log.levels.ERROR)
		end
	end
end
vim.api.nvim_create_autocmd("PackChanged", { callback = hooks })
local cmp = require("plugins.cmp")
local lsp = require("plugins.lsp")
local generic = require("plugins.plugins")
local telescope = require("plugins.telescope")
local themes = require("plugins.themes")
local visuals = require("plugins.visuals")
local pluginlist = pluginget({ cmp, lsp, generic, themes, visuals, telescope })
for _, value in ipairs(pluginlist) do
	local versioning = value.version ~= nil
	local opting = value.opts ~= nil
	local configing = value.config ~= nil
	local name = value.name
	if versioning then
		vim.pack.add({ { src = gh(value[1]), versioning = vim.version.range(value.version), name = name } })
	else
		vim.pack.add({ { src = gh(value[1]), name = name } })
	end

	if opting then
		require(value.name).setup(value.opts)
	end
	if configing then
		value.config()
	end
end
-- load libs
require("lib.callonce")

--- load configs
require("config.theme")
-- load the configs
-- config ui
require("config.ui")
-- Config lsp
require("config.lsp")
-- setup conform
require("config.conform")
-- setup keybinds
require("config.keymapping")
-- setup alpha, in its own file due to size
require("config.alpha")
