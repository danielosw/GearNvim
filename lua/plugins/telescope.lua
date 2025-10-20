--[[
Telescope plugin configuration.
Telescope is a fuzzy finder for files, grep, buffers, and more.
This file configures:
- Core telescope plugin with keybindings
- FZF native integration for faster fuzzy finding
]]

return {
	-- Fuzzy finder for files, grep, buffers, help tags, and more
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
		},
		config = function()
			-- we do this so we can actually lazyload telescopre
			require("telescope").load_extension("noice")
		end,
	},
	-- FZF native integration for faster fuzzy finding
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
}
