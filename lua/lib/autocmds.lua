-- setup autocmds
---@param ev vim.api.keyset.events
local hooks = function(ev)
	local name, kind = ev.data.spec.name, ev.data.kind
	if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
		vim.system({
			"cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		}, { cwd = ev.data.path }):wait()
	elseif name == "blink.cmp" and (kind == "install" or kind == "update") then
		vim.notify("Building blink.cmp", vim.log.levels.INFO)
		local obj = vim.system({ "cargo", "build", "--release" }, { cwd = ev.data.path }):wait()
		if obj.code == 0 then
			vim.notify("Building blink.cmp done", vim.log.levels.INFO)
		else
			vim.notify("Building blink.cmp failed", vim.log.levels.ERROR)
		end
	end
end
local callback = function()
	require("snacks").lazygit.open()
end
vim.api.nvim_create_user_command("Lazygit", callback, { desc = "opens lazygit" })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "alpha",
	callback = function()
		vim.opt_local.foldenable = false
	end,
})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
vim.api.nvim_create_autocmd("PackChanged", { callback = hooks })
