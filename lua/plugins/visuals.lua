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
		event = { "BufReadPre", "BufNewFile" },
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
		event = { "BufReadPre", "BufNewFile" },
		cmd = "TSUpdate",
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
		"stevearc/dressing.nvim",
		opts = {},
	},
	{
		"nvim-tree/nvim-tree.lua",
		opts = { hijack_unnamed_buffer_when_opening = true, hijack_netrw = true },
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
}
