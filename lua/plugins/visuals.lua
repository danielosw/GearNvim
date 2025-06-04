local menuoption = {
	{
		name = "Format Buffer",
		cmd = function()
			require("conform").format({ async = true })
		end,
		rtxt = "<leader>f",
	},

	{
		name = "Code Actions",
		cmd = function()
			require("actions-preview").code_actions()
		end,
		rtxt = "<leader>gf",
	},

	{ name = "separator" },

	{
		name = "  Lsp Actions",
		hl = "Exblue",
		items = "lsp",
	},

	{ name = "separator" },

	{
		name = "Edit Config",
		cmd = function()
			vim.cmd("tabnew")
			vim.cmd(":e $MYVIMRC | :cd %:p:h | NvimTreeOpen | wincmd k | pwd<CR>")
		end,
	},

	{
		name = "Copy Content",
		cmd = "yank",
		rtxt = "<C-c>",
	},
	{
		name = "Delete Content",
		cmd = "%d",
		rtxt = "dc",
	},

	{ name = "separator" },

	{
		name = "  Open in terminal",
		hl = "ExRed",
		cmd = function()
			local old_buf = require("menu.state").old_data.buf
			local old_bufname = vim.api.nvim_buf_get_name(old_buf)
			local old_buf_dir = vim.fn.fnamemodify(old_bufname, ":h")

			local cmd = "cd " .. old_buf_dir

			-- base46_cache var is an indicator of nvui user!
			if vim.g.base46_cache then
				require("nvchad.term").new({ cmd = cmd, pos = "sp" })
			else
				vim.cmd("new")
				vim.fn.termopen({ vim.o.shell, "-c", cmd .. " ; " .. vim.o.shell })
			end
		end,
	},

	{ name = "separator" },
}
return {
	{
		"MunifTanjim/nougat.nvim",
		config = function()
			require("config.nougat")
		end,
	},
	{
		"hiphish/rainbow-delimiters.nvim",
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
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
			highlight = { enable = true },
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"nvim-neorg/neorg",

		version = "*", -- Pin Neorg to the latest stable release
		lazy = false,
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
		"lewis6991/hover.nvim",
		config = function()
			require("hover").setup({
				init = function()
					-- Require providers
					require("hover.providers.lsp")
					-- require('hover.providers.gh')
					-- require('hover.providers.gh_user')
					-- require('hover.providers.jira')
					require("hover.providers.dap")
					-- require('hover.providers.fold_preview')
					-- require('hover.providers.diagnostic')
					require("hover.providers.man")
					-- require('hover.providers.dictionary')
					vim.o.mousemoveevent = true
				end,
				preview_opts = {
					border = "single",
				},
				-- Whether the contents of a currently open hover window should be moved
				-- to a :h preview-window when pressing the hover keymap.
				preview_window = false,
				title = true,
				mouse_providers = {
					"LSP",
				},
				mouse_delay = 1000,
			})
			vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
			vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
			vim.keymap.set("n", "<C-p>", function()
				require("hover").hover_switch("previous")
			end, { desc = "hover.nvim (previous source)" })
			vim.keymap.set("n", "<C-n>", function()
				require("hover").hover_switch("next")
			end, { desc = "hover.nvim (next source)" })

			-- Mouse support
			vim.keymap.set("n", "<MouseMove>", require("hover").hover_mouse, { desc = "hover.nvim (mouse)" })
			vim.o.mousemoveevent = true
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		opts = { hijack_unnamed_buffer_when_opening = true, hijack_netrw = true },
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
}
