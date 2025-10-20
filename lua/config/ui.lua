--[[
UI Configuration for enhanced user interface elements.
This file configures:
- Noice: Modern UI for messages, cmdline, and popupmenu
- Navigation breadcrumbs in the window bar
- Lazygit integration command
]]

-- Configure Noice for improved UI/UX
require("noice").setup({
	lsp = {
		-- Override markdown rendering so that completion and other plugins use Treesitter
		-- This provides better syntax highlighting in documentation
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
		},
	},
	-- Enable preset configurations for common UI improvements
	presets = {
		bottom_search = true,           -- Use classic bottom cmdline for search
		command_palette = true,         -- Position cmdline and popupmenu together
		long_message_to_split = true,   -- Send long messages to a split window
		inc_rename = false,             -- Disable input dialog for inc-rename.nvim
		lsp_doc_border = false,         -- No border for hover docs and signature help
	},
})

-- Setup navigation breadcrumbs in window bar
-- Shows current code context (file, function, class, etc.)
vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

-- Create Lazygit command for git integration
local callback = function()
	require("snacks").lazygit.open()
end
vim.api.nvim_create_user_command("Lazygit", callback, { desc = "opens lazygit" })
