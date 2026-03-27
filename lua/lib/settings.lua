-- settings.lua
---@class QuotesConfig
---@field inspire boolean
---@field comedy boolean
---@field other boolean

---@class ConfigTable
---@field quotes QuotesConfig
---@field neorg boolean
---@field debugLazy boolean
---@field codeLens boolean
---@type ConfigTable
local M = {
	quotes = {
		inspire = true,
		comedy = true,
		other = true,
	},
	neorg = false,
	debugLazy = false,
	codeLens = true,
}
return M
