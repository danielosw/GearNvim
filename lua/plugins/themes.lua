--[[
Colorscheme/theme plugin definitions.
This file configures various color themes for Neovim.
Priority is set high (200+) to ensure themes load early.
Use :Themes command to interactively switch between themes.
]]

return {
	-- Catppuccin: Soothing pastel theme with multiple flavors
	{ "catppuccin/nvim", name = "catppuccin", priority = 200 },
	
	-- Tokyo Night: Clean and elegant dark theme
	{ "folke/tokyonight.nvim", priority = 200 },
	
	-- Nightfox: Highly customizable fox-themed colorschemes
	{ "EdenEast/nightfox.nvim", priority = 200 },
	
	-- Oxocarbon: IBM Carbon-inspired dark theme
	{ "nyoom-engineering/oxocarbon.nvim", priority = 200 },
	
	-- Dracula: Dark theme inspired by Dracula color palette
	{
		"Mofiqul/dracula.nvim",
		priority = 200,
		opts = Termconf.draculaopts,
	},
	
	-- OneDark Pro: Atom's iconic One Dark theme
	{
		"olimorris/onedarkpro.nvim",
		priority = 200,
	},
	
	-- Bluloco: Blue-based theme with light and dark variants
	{
		"uloco/bluloco.nvim",
		lazy = false,
		priority = 1000,
		dependencies = { "rktjmp/lush.nvim" },
	},
	
	-- Cyberdream: Modern cyberpunk-inspired theme
	{
		"scottmckendry/cyberdream.nvim",
		priority = 1000,
		opts = {
			variant = "default", -- use "light" for the light variant. Also accepts "auto" to set dark or light colors based on the current value of `vim.o.background`

			-- Enable transparent background
			--transparent = true,

			-- Reduce the overall saturation of colours for a more muted look
			saturation = 1, -- accepts a value between 0 and 1. 0 will be fully desaturated (greyscale) and 1 will be the full color (default)

			-- Enable italics comments
			italic_comments = false,

			-- Replace all fillchars with ' ' for the ultimate clean look
			hide_fillchars = false,

			-- Apply a modern borderless look to pickers like Telescope, Snacks Picker & Fzf-Lua
			borderless_pickers = true,

			-- Set terminal colors used in `:terminal`
			terminal_colors = true,

			-- Improve start up time by caching highlights. Generate cache with :CyberdreamBuildCache and clear with :CyberdreamClearCache
			cache = true,
			--[[
			-- Override highlight groups with your own colour values
			highlights = {
				-- Highlight groups to override, adding new groups is also possible
				-- See `:h highlight-groups` for a list of highlight groups or run `:hi` to see all groups and their current values

				-- Example:
				Comment = { fg = "#696969", bg = "NONE", italic = true },

				-- More examples can be found in `lua/cyberdream/extensions/*.lua`
			},

			-- Override a highlight group entirely using the built-in colour palette
		-	overrides = function(colors) -- NOTE: This function nullifies the `highlights` option
			-- Example:
					return {
						Comment = { fg = colors.green, bg = "NONE", italic = true },
						["@property"] = { fg = colors.magenta, bold = true },
					}
				end,

			-- Override colors
		colors = {
				-- For a list of colors see `lua/cyberdream/colours.lua`

				-- Override colors for both light and dark variants
				bg = "#000000",
				green = "#00ff00",

				-- If you want to override colors for light or dark variants only, use the following format:
				dark = {
					magenta = "#ff00ff",
					fg = "#eeeeee",
				},
				light = {
					red = "#ff5c57",
					cyan = "#5ef1ff",
				},*/
			},
			]]
			--
			-- Disable or enable colorscheme extensions
			extensions = {
				telescope = true,
				notify = true,
				alpha = true,
				blinkcmp = true,
				snacks = true,
				rainbow_delimiters = true,
				treesitter = true,
				lazy = true,
				noice = true,
				...,
			},
		},
	},
	{ "rktjmp/shipwright.nvim", lazy = true },
	{
		"rktjmp/lush.nvim",
		lazy = true,
		-- if you wish to use your own colorscheme:
	},
}
