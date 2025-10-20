--[[
Alpha dashboard configuration.
This file configures the start screen shown when opening Neovim.
Features:
- Random ASCII art header selection
- Random inspirational quote in footer
- Quick action buttons for common tasks
]]

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
require("lib.quotes")

-- ASCII art headers for the dashboard
local headers = {
	{
		"                                                     ",
		"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
		"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
		"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
		"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
		"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
		"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
		"                                                     ",
	},
	{
		[[                                                                   ]],
		[[      ████ ██████           █████      ██                    ]],
		[[     ███████████             █████                            ]],
		[[     █████████ ███████████████████ ███   ███████████  ]],
		[[    █████████  ███    █████████████ █████ ██████████████  ]],
		[[   █████████ ██████████ █████████ █████ █████ ████ █████  ]],
		[[ ███████████ ███    ███ █████████ █████ █████ ████ █████ ]],
		[[██████  █████████████████████ ████ █████ █████ ████ ██████]],
	},
}
-- Randomly select a header from the available options
dashboard.section.header.val = headers[math.random(#headers)]

-- Randomly select a quote for the footer
dashboard.section.footer.val = Quotes[math.random(#Quotes)]

-- Define quick action buttons for the dashboard
dashboard.section.buttons.val = {
	dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("f", "󰱼  > Find file", ":Telescope find_files<CR>"),
	dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
	dashboard.button("w", "  > Find text", ":Telescope live_grep<CR>"),
	dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h | NvimTreeOpen | wincmd k | pwd<CR>"),
	dashboard.button("t", "󱃩  > Open folder", ":e .| NvimTreeOpen | wincmd k | pwd<CR>"),
	dashboard.button("q", "󰰲  > Quit NVIM", ":qa<CR>"),
}
-- Apply dashboard configuration
alpha.setup(dashboard.opts)

-- Disable folding on the alpha dashboard
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
