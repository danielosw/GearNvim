return {
	{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },
	{
		"chrisgrieser/nvim-rip-substitute",
		cmd = "RipSubstitute",
		opts = {},
		keys = {
			{
				"<leader>fs",
				function()
					require("rip-substitute").sub()
				end,
				mode = { "n", "x" },
				desc = " rip substitute",
			},
		},
	},
	{
		"chrisgrieser/nvim-scissors",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = {
			{
				"<leader>se",
				function()
					require("scissors").editSnippet()
				end,
				mode = { "n" },
				desc = "Snippet: Edit",
			},
			{
				"<leader>sa",
				function()
					require("scissors").addNewSnippet()
				end,
				mode = { "n", "x" },
				desc = "Snippet: Add",
			},
		},
		opts = {

			snippetDir = ConfigPath .. "/snippets",
		},
	},
}
