-- settings.lua
---@alias IndentStyle
---| '"tabs"'
---| '"spaces"'
---| '"auto-prefer-tabs"'
---| '"auto-prefer-spaces"'
---@class QuotesConfig
---@field inspire boolean
---@field comedy boolean
---@field other boolean
---@class ConfigTable
---@field quotes QuotesConfig
---@field spacing IndentStyle
---@type ConfigTable
local M = {
	quotes = {
		inspire = true,
		comedy = true,
		other = true,
	},
	spacing = "tabs"
}
return M
