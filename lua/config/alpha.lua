local alpha = require("alpha")
require("lib.quotes")
local lazy = require("lazy.stats")
local leader = ","
local if_nil = vim.F.if_nil
-- Taken from alpha.themes.dashboard.button
--- @param sc string
--- @param txt string
--- @param keybind string? optional
--- @param keybind_opts table? optional
local function button(sc, txt, keybind, keybind_opts)
	local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

	local opts = {
		position = "center",
		shortcut = sc,
		cursor = 3,
		width = 50,
		align_shortcut = "right",
		hl_shortcut = "Keyword",
	}
	if keybind then
		keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
		opts.keymap = { "n", sc_, keybind, keybind_opts }
	end

	local function on_press()
		local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
		vim.api.nvim_feedkeys(key, "t", false)
	end

	return {
		type = "button",
		val = txt,
		on_press = on_press,
		opts = opts,
	}
end
local function footer_text(txt)
	return { type = "text", val = txt, opts = {
		position = "center",
		hl = "Number",
	} }
end
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
local terminal = {
	type = "terminal",
	command = nil,
	width = 69,
	height = 8,
	opts = {
		redraw = true,
		window_config = {},
	},
}

local header = {
	type = "text",
	val = headers[math.random(#headers)],
	opts = {
		position = "center",
		hl = "Type",
		-- wrap = "overflow";
	},
}

local footer = {
	type = "group",
	val = {
		footer_text(Quotes[math.random(#Quotes)]),
		footer_text("Started in " .. lazy.cputime() .. " MS!"),
	},
	opts = { spacing = 1 },
}

local buttons = {
	type = "group",
	val = {
		button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
		button("f", "󰱼  > Find file", ":Telescope find_files<CR>"),
		button("r", "  > Recent", ":Telescope oldfiles<CR>"),
		button("w", "  > Find text", ":Telescope live_grep<CR>"),
		button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h | NvimTreeOpen | wincmd k | pwd<CR>"),
		button("t", "󱃩  > Open folder", ":e .| NvimTreeOpen | wincmd k | pwd<CR>"),
		button("q", "󰰲  > Quit NVIM", ":qa<CR>"),
	},
	opts = {
		spacing = 1,
	},
}

local section = {
	terminal = terminal,
	header = header,
	buttons = buttons,
	footer = footer,
}

local config = {
	layout = {
		{ type = "padding", val = 2 },
		section.header,
		{ type = "padding", val = 2 },
		section.buttons,
		section.footer,
	},
	opts = {
		margin = 5,
	},
}

local startup_screen = {
	button = button,
	section = section,
	config = config,
	-- theme config
	leader = leader,
	-- deprecated
	opts = config,
}
alpha.setup(startup_screen.config)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "alpha",
	callback = function()
		vim.opt_local.foldenable = false
	end,
})
