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
	"Even the waves of fate can break upon the shores of will.",
	"Should the lights go out and all laws flee, you will get where you are going.",
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
}
if Comedy then
	for _, v in ipairs(funny) do
		Quotes[#Quotes + 1] = v
	end
end
