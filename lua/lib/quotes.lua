---This file is a list of quotes to randomly load on start
local quote = require("lib/settings").quotes
local Inspire = quote.inspire
local Comedy = quote.comedy
local Other = quote.other
--
--Vaugly inspiring

local inspire = {
	"Strive for progress.",
	"Nothing about us without us.",
	"Even the waves of fate can break upon the shores of will.",
	"Should the lights go out and all laws flee, you will get where you are going.",
}
--Comedy

local funny = {
	"I use Arch btw",
}
-- other
local other = {
	"One day I will go north to the end of the world, stained with the inks of the violet undernight, and there will I burn",
}
-- Build the quotes table
Quotes = {}
if Inspire then
	vim.list_extend(Quotes, inspire)
end
if Comedy then
	vim.list_extend(Quotes, funny)
end
if Other then
	vim.list_extend(Quotes, other)
end
