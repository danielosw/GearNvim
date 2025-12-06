require("mason").setup()
require("mason-nvim-dap").setup()
Mason_registry = require("mason-registry")
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
	["pylsp"] = true,
	["astro"] = true,
	["bashls"] = true,
	["cmake"] = true,
	["docker_compose_language_service"] = true,
	["fish_lsp"] = true,
	["jdtls"] = true,
	["lemminx"] = true,
	["ruby_lsp"] = true,
	["taplo"] = true,
	["zls"] = true,
	["eslint"] = true,
	["omnisharp"] = true,
	["intelephense"] = true,
	["hls"] = true,
	["denols"] = true,
}
for i, name in pairs(enabled_server) do
	vim.lsp.enable(i, name)
end
