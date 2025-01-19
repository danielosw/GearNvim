local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- Helper that calls some stuff once so we don't do it over and over
require("helpers.callonce")
if Windows then
	-- set shell to powershell on windows.
	vim.o.shell = "pwsh.exe"
end
-- install lazy if not installed already
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-- add mise shims to path if on linux and shims path exists
if Windows ~= true and vim.uv.fs_stat("~/.local/share/mise/shims") then
	vim.env.PATH = HOME .. "~/.local/share/mise/shims:" .. vim.env.PATH
end
-- config things that need to be changed before plugins are loaded
local g = vim.g
local opt = vim.opt
local o = vim.o
g.mapleader = ","
g.maplocalleader = ","
-- disable netrw because we are using NvimTree
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
vim.loader.enable()
opt.termguicolors = true
-- Disabling default style's
g.python_recommended_style = 0
g.rust_recommended_style = 0
-- Enabling tabs and setting their size
opt.expandtab = false
o.tabstop = 4
o.shiftwidth = 4
o.number = true
-- Disabling this to use tiny inline diagnostic
vim.diagnostic.config({ virtual_text = false })
-- terminal specific config options
require("helpers.terms")

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"netrwPlugin",
			},
		},
	},
})
-- load the configs
-- dap helper to load dap configs on filetypes
require("helpers.inittypes")
-- config ui
require("config.ui")
-- Config mason and related
-- TODO: rename and split up this config
require("config.mason")
-- setup conform
require("config.conform")
-- setup dap, MUST HAPPEN AFTER MASON CONFIG
require("config.dapset")
-- setup cmp and snippets
require("config.cmp")
-- setup keybinds
require("config.keybinds")
-- setup alpha, in its own file due to size
require("config.alpha")
-- if we are using neovide load neovide specific options
if vim.g.neovide then
	require("config.neovide")
end
