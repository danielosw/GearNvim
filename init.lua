require("lib.callonce")
-- load autocmds
require("lib.autocmds")
-- load plugin manager
local manager = require("lib.manager")
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
local pluginlist = manager.pluginsetup({ "cmp", "lsp", "plugins", "themes", "visuals", "telescope" })

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
require("config.telescope")
