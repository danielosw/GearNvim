-- settings.lua
---@class QuotesConfig
---@field inspire boolean
---@field comedy boolean
---@field other boolean

---@class ConfigTable
---@field quotes QuotesConfig
---@type ConfigTable
local M = {
	quotes = {
		inspire = true,
		comedy = true,
		other = true,
	},
}
return M
