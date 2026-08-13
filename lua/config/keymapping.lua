local telescope = require("telescope.builtin")
Quickmap({ "<space>e", vim.diagnostic.open_float }, { desc = "Show diagnostic in floating window" })
Quickmap({ "<leader>q", vim.diagnostic.setloclist }, { desc = "Add buffer diagnostics to location list" })

Quickmap({ "<leader>gg", require("snacks").lazygit.open }, { desc = "Open lazygit" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		Quickmap({ "gD", vim.lsp.buf.declaration }, { buffer = ev.buf, desc = "Get declaration" })
		Quickmap({ "gd", vim.lsp.buf.definition }, { buffer = ev.buf, desc = "Get definition" })
		Quickmap({ "gh", vim.lsp.buf.hover }, { buffer = ev.buf, desc = "Show hover information" })
		Quickmap({ "gi", vim.lsp.buf.implementation }, { buffer = ev.buf, desc = "Get implementation" })
		Quickmap({ "<C-k>", vim.lsp.buf.signature_help }, { buffer = ev.buf, desc = "Show siginature information" })
		Quickmap({
			"<leader>wa",
			vim.lsp.buf.add_workspace_folder,
		}, { buffer = ev.buf, desc = "Add folder at path to workspace" })
		Quickmap({ "<leader>wr", vim.lsp.buf.remove_workspace_folder }, opts)
		Quickmap({
			"<leader>wl",
			function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end,
		}, { buffer = ev.buf, desc = "List workspace folders" })
		Quickmap(
			{ "<leader>D", vim.lsp.buf.type_definition },
			{ buffer = ev.buf, desc = "Jump to the definition of the type hovered over" }
		)

		Quickmap({ "<leader>rn", vim.lsp.buf.rename }, { buffer = ev.buf, desc = "Rename symbol" })
		Quickmap({ mode = { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action }, opts)
		Quickmap({ mode = { "n", "v" }, "<leader>cc", vim.lsp.codelens.run }, opts)
	end,
})
Quickmap({ mode = { "n", "x" }, "<leader>fs", require("rip-substitute").sub }, { desc = "open rip-substitute" })
Quickmap({
	"<leader>ff",
	telescope.find_files,
}, { desc = "search files" })
Quickmap({
	"<leader>fg",
	telescope.live_grep,
}, { desc = "search in all files" })
Quickmap({
	"<leader>fb",
	telescope.buffers,
}, { desc = "search in buffers" })
Quickmap({
	"<leader>fh",
	telescope.help_tags,
}, { desc = "search in help tags" })
Quickmap({
	"<C-n>",
	vim.cmd.NvimTreeToggle,
}, { desc = "toggle NvimTree" })
Quickmap({ "<leader>fl", telescope.current_buffer_fuzzy_find }, { desc = "search in current buffer" })
Quickmap({
	"<leader>?",
	function()
		require("which-key").show({ global = false })
	end,
})
Quickmap({ mode = { "v", "n" }, "gf", require("actions-preview").code_actions }, { desc = "Preview code actions" })
