local navic = require("nvim-navic")
local navbud = require("nvim-navbuddy")
-- lsp on attach
local on_attach = function(client, bufnr)
	-- navic
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
		navbud.attach(client, bufnr)
	end
	-- enable inlay hints if possible
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true)
	end
	if client:supports_method("textDocument/codeLens") and Codelens then
		vim.lsp.codelens.refresh()

		--- autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()

		vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {

			buffer = bufnr,

			callback = vim.lsp.codelens.refresh,
		})
	end
end
-- run on attach for all lsps
vim.lsp.config("*", { on_attach = on_attach })
-- rust lsp config
vim.lsp.config("rust_analyzer", {
	on_attach = on_attach,
	settings = {
		["rust-analyzer"] = {
			checkOnSave = {
				command = "clippy",
			},
			lens = {
				enable = true,
			},
			completion = {
				fullFunctionSignatures = {
					enable = true,
				},
			},
			inlayHints = {
				closureReturnTypeHints = {
					enable = true,
				},
			},
			semanticHighlighting = {
				operator = {
					specialization = {
						enable = true,
					},
				},
			},
			procMacro = {
				enable = true,
			},
		},
	},
})
-- pylsp config
vim.lsp.config("pylsp", {
	on_attach = on_attach,
	settings = {
		-- disable all plugins but rope
		plugins = {
			autopep8 = {
				enabled = false,
			},
			mccabe = {
				enabled = false,
			},
			pycodestyle = {
				enabled = false,
			},
			pyflakes = {
				enabled = false,
			},
			yapf = {
				enabled = false,
			},
		},
	},
})
-- lualsp config
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			codeLens = {
				enable = true,
			},
		},
	},
})
vim.lsp.config("hls", {
	settings = {
		haskell = {
			plugin = {
				importLens = {
					codeLensOn = false,
					codeActionsOn = false,
				},
			},
		},
	},
})
