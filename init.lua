require("lib.callonce")
local windows = Globals.Windows
local ConfigPath = Globals.ConfigPath
-- load autocmds
require("lib.autocmds")
-- if theme.lua does not exist, make it to prevent a crash
if not vim.uv.fs_stat(ConfigPath .. "/lua/config/theme.lua") then
	local cat = RealPath("/lua/config/theme.lua")
	local file = vim.uv.fs_open(ConfigPath .. cat, "w+", 438)
	if file ~= nil then
		-- not my fav theme but its common
		vim.uv.fs_write(file, 'vim.cmd.colorscheme("tokyonight-storm")')
		vim.uv.fs_close(file)
	end
end
-- load plugin manager
local manager = require("lib.manager")
local g = vim.g
local opt = vim.opt
local o = vim.o
if windows ~= true then
	o.clipboard = "unnamedplus"
else
	o.clipboard = "unnamed"
	-- set shell to powershell on windows with proper flags
	vim.o.shell = "pwsh.exe"
	vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
	vim.o.shellquote = ""
	vim.o.shellxquote = ""
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
if vim.g.neovide then
	require("config.neovide")
end

-- load plugins
manager.pluginsetup({ "cmp", "lsp", "plugins", "themes", "visuals", "telescope" })

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
