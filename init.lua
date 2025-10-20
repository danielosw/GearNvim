--[[
GearNvim - Main configuration entry point
A customizable Neovim configuration focused on LSP, debugging, and modern UI features.
Requires Neovim 0.11+ and external dependencies: cmake, ripgrep, yarn, fzf
]]

-- Debug flag for Lazy plugin manager profiling
-- Set to true to enable loader and require profiling for optimization
local debuglazy = true

-- Feature flags (MUST BE SET BEFORE PLUGIN LOADING)

-- Enable Neorg for note-taking and organization
-- Set to false by default because neorg treesitter parser must be manually installed
EnableNeorg = false

-- Enable LSP code lens feature
-- Set to false by default to avoid notification spam
Codelens = false

-- Load global utility functions and variables
-- This sets up platform detection, paths, and helper functions
require("lib.callonce")
-- Create default theme.lua if it doesn't exist to prevent crashes
-- Uses tokyonight-storm as the default theme
if not vim.uv.fs_stat(ConfigPath .. "/lua/config/theme.lua") then
	local cat = RealPath("/lua/config/theme.lua")
	local file = vim.uv.fs_open(ConfigPath .. cat, "w+", 438)
	if file ~= nil then
		-- not my fav theme but its common
		vim.uv.fs_write(file, 'vim.cmd("colorscheme tokyonight-storm")')
	end
end

-- Bootstrap Lazy.nvim plugin manager
local lazypath = DataPath .. "/lazy/lazy.nvim"

-- Platform-specific shell configuration
if Windows then
	-- Use PowerShell on Windows for better compatibility
	vim.o.shell = "pwsh.exe"
end

-- Install Lazy.nvim if not already installed
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
-- Add Lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- Add mise shims to PATH on Unix-like systems
-- mise is a tool version manager (like asdf)
if Windows ~= true and vim.uv.fs_stat("~/.local/share/mise/shims") then
	vim.env.PATH = HOME .. "~/.local/share/mise/shims:" .. vim.env.PATH
end

-- Pre-plugin configuration
-- These settings must be set before loading plugins
local g = vim.g
local opt = vim.opt
local o = vim.o
-- Clipboard configuration
-- Use system clipboard for better integration
if Windows ~= true then
	o.clipboard = "unnamedplus"  -- Unix-like systems
else
	o.clipboard = "unnamed"      -- Windows
end

-- Leader key configuration
-- Set leader to comma for easier access to custom commands
g.mapleader = ","
g.maplocalleader = ","

-- Disable netrw (built-in file explorer)
-- We use NvimTree instead for a better file browsing experience
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Enable experimental Lua module loader for faster startup
vim.loader.enable()

-- Enable true color support
-- Disable this if your terminal doesn't support 24-bit colors
opt.termguicolors = true

-- Disable default language-specific formatting styles
-- This allows using custom formatters instead
g.python_recommended_style = 0
g.rust_recommended_style = 0

-- Tab and indentation settings
opt.expandtab = false  -- Use actual tab characters
o.tabstop = 4          -- Tab width
o.shiftwidth = 4       -- Indentation width
o.number = true        -- Show line numbers

-- Track whether theme picker has been loaded (for lazy loading)
Pickerloaded = false

-- Load terminal-specific configuration
require("lib.terms")

-- Lazy.nvim configuration
local lazydefault = {
	spec = {
		-- Import all plugin definitions from lua/plugins/
		{ import = "plugins" },
	},
	performance = {
		rtp = {
			-- Disable netrw plugin since we're using NvimTree
			disabled_plugins = {
				"netrwPlugin",
			},
		},
	},
}

-- Enable profiling if debug mode is enabled
if debuglazy then
	lazydefault.profiling = {
		loader = true,   -- Profile plugin loader
		require = true,  -- Profile require calls
	}
end

-- Development path for local plugin development
lazydefault.dev = {
	path = "~/projects/neovimplugins",
}

-- Load Neovide-specific configuration if running in Neovide GUI
if vim.g.neovide then
	require("config.neovide")
end

-- Initialize Lazy.nvim with plugins
require("lazy").setup(lazydefault)

-- Setup Treesitter-based indentation
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

-- Load colorscheme early for proper UI rendering
require("config.theme")

-- Load configuration modules
require("config.ui")        -- UI enhancements (noice, navic)
require("config.mason")     -- LSP/DAP setup with Mason
require("config.conform")   -- Code formatting
require("config.keybinds")  -- Keybinding setup
require("config.alpha")     -- Start screen

-- Lazy-load theme picker to avoid loading Telescope at startup
local function pickwrapper()
	-- Lazy-load telescope configuration only when theme picker is first used
	if Pickerloaded == false then
		require("config.telescope")
		Pickerloaded = true
	end
	-- Open theme picker
	Themepick()
end

-- Create :Themes command for interactive theme selection
vim.api.nvim_create_user_command("Themes", pickwrapper, { desc = "theme picker" })
