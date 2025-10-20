--[[
Keybinding configuration for LSP, diagnostics, and git integration.
This file sets up:
- Global keybindings for diagnostics
- Git integration shortcuts
- LSP-specific keybindings when an LSP server attaches to a buffer
]]

-- Global diagnostic keybindings
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)  -- Open diagnostic float window
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist) -- Add diagnostics to location list

-- Git integration keybinding
vim.keymap.set("n", "<leader>gg", require("snacks").lazygit.open)  -- Open lazygit

-- Setup LSP keybindings when an LSP server attaches to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, opts)
		vim.keymap.set({ "n" }, "<leader>cC", vim.lsp.codelens.refresh, opts)
	end,
})
