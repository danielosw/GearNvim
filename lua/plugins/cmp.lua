return {
	{ "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", opts = {} },
	{ "iguanacucumber/mag-buffer", name = "cmp-buffer" },
	{ "iguanacucumber/mag-cmdline", name = "cmp-cmdline" },
	{ --* the completion engine *--
		"iguanacucumber/magazine.nvim",

		name = "nvim-cmp", -- Otherwise highlighting gets messed up
	},
	"https://codeberg.org/FelipeLema/cmp-async-path",
	{ "saadparwaiz1/cmp_luasnip" },
	{ "onsails/lspkind.nvim", lazy = true },

	{
		"L3MON4D3/LuaSnip",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load({
				paths = ConfigPath .. "/snippets",
			})
		end,
		build = function()
			if Windows then
				return
			else
				return "make install_jsregexp"
			end
		end,
		dependencies = { "rafamadriz/friendly-snippets" },
	},
}
