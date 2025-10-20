--[[
Visual enhancement plugins configuration.
This file configures UI and visual plugins including:
- Status line (lualine)
- Rainbow delimiters for bracket matching
- Noice for improved UI messages
- Navigation breadcrumbs and file trees
- Git integration and visualizations
]]

return {
	-- Status line with icons and git integration
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			theme = "auto",
			extensions = { "nvim-tree", "lazy" },
		},
	},
	-- Rainbow brackets/delimiters for better code readability
	{
		"hiphish/rainbow-delimiters.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			---@type rainbow_delimiters.config
			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = "rainbow-delimiters.strategy.global",
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				priority = {
					[""] = 110,
					lua = 210,
				},
				highlight = {
					--- TsRainbow has better support
					"TsRainbowRed",
					"TsRainbowYellow",
					"TsRainbowBlue",
					"TsRainbowOrange",
					"TsRainbowGreen",
					"TsRainbowViolet",
					"TsRainbowCyan",
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			}
		end,
		submodules = false,
	},
	-- Modern UI for messages, cmdline, and popupmenu
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	-- Buffer line showing open files as tabs
	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				separator_style = "slant",
				themable = true,
			},
		},
		event = { "BufReadPre", "BufNewFile" },
	},
	-- Auto-color file icons based on current colorscheme
	{
		"rachartier/tiny-devicons-auto-colors.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
	},
	-- Treesitter: Advanced syntax highlighting and code understanding
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		branch = "main",
		opts = {
			ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "regex" },
			highlight = { enable = true },
		},
	},
	-- Neorg: Note-taking and organization (optional, controlled by EnableNeorg flag)
	{
		"danielosw/neorg",

		lazy = false,
		cond = EnableNeorg,
		opts = {
			load = {
				["core.defaults"] = {},
				["core.completion"] = { config = { engine = "nvim-cmp" } },
				["core.concealer"] = {},
				["core.dirman"] = {
					config = {
						workspaces = {
							main = "~/notes",
						},
						index = "index.norg",
					},
				},
				["core.export"] = {},
			},
		},
	},

	-- Alpha: Customizable start screen/dashboard
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
	},
	
	-- Navic: Navigation breadcrumbs in status/winbar
	{
		"SmiteshP/nvim-navic",
		opts = {
			lsp = {
				auto_attach = false,
				preference = nil,
			},
			highlight = true,
			separator = " > ",
			depth_limit = 10,
			depth_limit_indicator = "..",
			click = true,
		},
		lazy = true,
	},
	-- Navbuddy: Popup for navigating code symbols
	{
		"SmiteshP/nvim-navbuddy",
		dependencies = {
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim",
		},
		lazy = true,
	},
	-- Illuminate: Highlight word under cursor throughout file
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPre", "BufNewFile" },
	},
	
	-- Snacks: Collection of useful utilities (lazygit, notifications, etc.)
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			bigfile = { enabled = true },
			dashboard = { enabled = false },
			explorer = { enabled = false },
			indent = { enabled = false },
			input = { enabled = true },
			picker = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = not vim.g.neovide },
			statuscolumn = { enabled = false },
			words = { enabled = true },
			image = { enabled = true },
			lazygit = { enabled = true },
			git = { enabled = true },
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCollapse" },
		keys = {
			{ "<C-n>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
		},
		opts = { hijack_unnamed_buffer_when_opening = true, hijack_netrw = true },
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
}
