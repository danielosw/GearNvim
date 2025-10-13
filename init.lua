-- set to true to change lazy config for debugging/optimising
-- has no real use besides this
local debuglazy = false
-- MUST BE SET BEFORE PLUGIN LOADING
-- if true enables neorg and related things.
-- false because you need to manually install neorg treesitter to get it to work
EnableNeorg = false
-- disables codelens due to notificaton spam
Codelens = false
-- Helper that calls some stuff once so we don't do it over and over
require("lib.callonce")
-- if theme.lua does not exist, make it to prevent a crash
if not vim.uv.fs_stat(ConfigPath .. "/lua/config/theme.lua") then
	local cat = RealPath("/lua/config/theme.lua")
	local file = vim.uv.fs_open(ConfigPath .. cat, "w+", 438)
	if file ~= nil then
		-- not my fav theme but its common
		vim.uv.fs_write(file, 'vim.cmd("colorscheme tokyonight-storm")')
	end
end

local lazypath = DataPath .. "/lazy/lazy.nvim"
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
-- set up clipboard
if Windows ~= true then
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
-- enable experimental loader
vim.loader.enable()
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
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "<filetype>" },
	callback = function()
		vim.treesitter.start()
	end,
})
-- terminal specific config options
require("lib.terms")

local lazydefault = {
	spec = {
		{ import = "plugins" },
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"netrwPlugin",
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
}
if debuglazy then
	lazydefault.profiling = {
		loader = true,
		require = true,
	}
end
lazydefault.dev = {
	path = "~/projects/neovimplugins",
}
-- if we are using neovide load neovide specific options
if vim.g.neovide then
	require("config.neovide")
end
require("lazy").setup(lazydefault)
-- treesitter indent guide
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
-- load colorscheme early on
require("config.theme")

-- Defer loading of non-critical configs
vim.schedule(function()
	-- load the configs
	-- dap helper to load dap configs on filetypes
	require("lib.inittypes")
	-- config ui
	require("config.ui")
	-- Config mason and related
	require("config.mason")
	-- setup conform
	require("config.conform")
	-- setup dap, MUST HAPPEN AFTER MASON CONFIG
	require("config.dapset")
	-- setup keybinds
	require("config.keybinds")
	-- load custom pickers
	require("config.telescope")
end)
