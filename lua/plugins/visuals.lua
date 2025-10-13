return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		opts = {
			theme = "auto",
			extensions = { "nvim-tree", "lazy" },
		},
	},
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
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
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
	{
		"rachartier/tiny-devicons-auto-colors.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		event = "VeryLazy",
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		branch = "main",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSUpdate", "TSInstall" },
		opts = {
			ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "regex" },
			highlight = { enable = true },
		},
	},
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

	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		lazy = true,
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")
			require("lib.quotes")
			local headers = {
				{
					"                                                     ",
					"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
					"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
					"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
					"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
					"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
					"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
					"                                                     ",
				},
				{
					[[                                                                   ]],
					[[      ████ ██████           █████      ██                    ]],
					[[     ███████████             █████                            ]],
					[[     █████████ ███████████████████ ███   ███████████  ]],
					[[    █████████  ███    █████████████ █████ ██████████████  ]],
					[[   █████████ ██████████ █████████ █████ █████ ████ █████  ]],
					[[ ███████████ ███    ███ █████████ █████ █████ ████ █████ ]],
					[[██████  █████████████████████ ████ █████ █████ ████ ██████]],
				},
			}
			-- randomly pick a header
			dashboard.section.header.val = headers[math.random(#headers)]
			-- randomly pick a quote
			dashboard.section.footer.val = Quotes[math.random(#Quotes)]
			dashboard.section.buttons.val = {
				dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("f", "󰱼  > Find file", ":Telescope find_files<CR>"),
				dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
				dashboard.button("w", "  > Find text", ":Telescope live_grep<CR>"),
				dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h | NvimTreeOpen | wincmd k | pwd<CR>"),
				dashboard.button("t", "󱃩  > Open folder", ":e .| NvimTreeOpen | wincmd k | pwd<CR>"),
				dashboard.button("q", "󰰲  > Quit NVIM", ":qa<CR>"),
			}
			alpha.setup(dashboard.opts)
			vim.cmd([[
				autocmd FileType alpha setlocal nofoldenable
			]])
		end,
	},
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
	{
		"SmiteshP/nvim-navbuddy",
		dependencies = {
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim",
		},
		lazy = true,
	},
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPre", "BufNewFile" },
	},
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
		cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFileToggle" },
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
		},
		opts = { hijack_unnamed_buffer_when_opening = true, hijack_netrw = true },
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
}
