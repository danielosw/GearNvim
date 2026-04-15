-- setup lsp configs
require("lib.lspconfigs")
-- Define navic winbar.
vim.o.winbar = "%{%v:lua.require('nvim-navic').get_location()%}"
local enabled_server = {
	["clangd"] = true,
	["lua_ls"] = true,
	["svelte"] = true,
	["tailwindcss"] = true,
	["ts_ls"] = true,
	["cssls"] = true,
	["html"] = true,
	["jsonls"] = true,
	["rust_analyzer"] = true,
	["pylsp"] = false,
	["astro"] = false,
	["bashls"] = true,
	["cmake"] = false,
	["docker_compose_language_service"] = false,
	["fish_lsp"] = false,
	["jdtls"] = false,
	["lemminx"] = false,
	["ruby_lsp"] = true,
	["taplo"] = true,
	["zls"] = true,
	["eslint"] = true,
	["omnisharp"] = false,
	["intelephense"] = false,
	["hls"] = true,
	["powershell_es"] = true,
	["denols"] = true,
	["basedpyright"] = true,
}
vim.api.nvim_create_autocmd("User", {
	pattern = "LazyVimStarted",
	once = true,
	callback = function()
		for i, name in pairs(enabled_server) do
			vim.lsp.enable(i, name)
		end
	end,
})
