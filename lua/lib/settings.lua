-- settings.lua
---@class QuotesConfig
---@field inspire boolean
---@field comedy boolean
---@field other boolean

---@class ConfigTable
---@field quotes QuotesConfig
---@field neorg boolean

M = {
	quotes = {
		inspire = true,
		comedy = true,
		other = true,
	},
	neorg = false,
}
return M
