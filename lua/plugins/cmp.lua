return {
	{ "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", opts = {}, cond = NVscode },
	{ "iguanacucumber/mag-buffer", name = "cmp-buffer", cond = NVscode },
	{ "iguanacucumber/mag-cmdline", name = "cmp-cmdline", cond = NVscode },
	{ --* the completion engine *--
		"iguanacucumber/magazine.nvim",

		name = "nvim-cmp",
		cond = NVscode,
	},
	{ "https://codeberg.org/FelipeLema/cmp-async-path", cond = NVscode },
	{ "saadparwaiz1/cmp_luasnip", cond = NVscode },
	{ "onsails/lspkind.nvim", lazy = true, cond = NVscode },

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
		cond = NVscode,
	},
}
