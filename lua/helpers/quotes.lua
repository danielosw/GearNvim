--[[
This file is a list of quotes to randomly load on start
]]
--
local Inspire = true
local Comedy = true
Quotes = {}
--[[
Vaugly inspiring
--]]
local inspire = {
	"Strive for progress.",
	"Nothing about us without us.",
}
if Inspire then
	for _, v in ipairs(inspire) do
		Quotes[#Quotes + 1] = v
	end
end
--[[
Comedy
--]]
local funny = {
	"I use Arch btw",
	"And your Albino Rat will need some days of leave, as she does not get along with frogs, citing some prehistoric battle between their kind.",
}
if Comedy then
	for _, v in ipairs(funny) do
		Quotes[#Quotes + 1] = v
	end
end
