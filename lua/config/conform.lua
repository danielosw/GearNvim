--[[
Conform configuration for code formatting.
This file sets up:
- Formatter mappings for different file types
- Format-on-save functionality
- Fallback to LSP formatting when specific formatters aren't available
]]

local conform = require("conform")

-- Helper function to check if a formatter is available
-- Returns the formatter if available, otherwise falls back to LSP formatting
local haveformat = function(bufnr, formatter)
	if conform.get_formatter_info(formatter, bufnr).available then
		return { formatter }
	else
		return { lsp_format = "fallback" }
	end
end
-- Special handler for Python using Ruff
-- Enables both ruff_format (formatting) and ruff_fix (linting) if available
local haveRuff = function(bufnr)
	local toReturn = {}
	if conform.get_formatter_info("ruff_format", bufnr).available then
		toReturn[#toReturn + 1] = "ruff_format"
	end
	if conform.get_formatter_info("ruff_fix", bufnr).available then
		toReturn[#toReturn + 1] = "ruff_fix"
	end
	if #toReturn == 0 then
		return { lsp_format = "fallback" }
	end
	return toReturn
end
-- Setup conform with formatters for each file type
conform.setup({
	formatters_by_ft = {
		lua = function(bufnr)
			return haveformat(bufnr, "stylua")
		end,
		rust = function(bufnr)
			return haveformat(bufnr, "rustfmt")
		end,
		python = function(bufnr)
			return haveRuff(bufnr)
		end,
		typescript = function(bufnr)
			return haveformat(bufnr, "biome")
		end,
		javascript = function(bufnr)
			return haveformat(bufnr, "biome")
		end,
		html = function(bufnr)
			return haveformat(bufnr, "biome")
		end,
		css = function(bufnr)
			return haveformat(bufnr, "biome")
		end,
		c = function(bufnr)
			return haveformat(bufnr, "clang-format")
		end,
		cpp = function(bufnr)
			return haveformat(bufnr, "clang-format")
		end,
		go = function(bufnr)
			return haveformat(bufnr, "gofmt")
		end,
		json = function(bufnr)
			return haveformat(bufnr, "biome")
		end,
	},
	["*"] = { "codespell" },  -- Run spell checker on all file types
})

-- Enable format on save for all file types
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
