local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)
function IsNotNeovide()
    if not vim.g.neovide then
        return true
    else
        return false
    end
end
vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.opt.termguicolors = true

require("lazy").setup("plugins")

require("bufferline").setup {
    options = {
    separator_style = "slant"
    }

}
vim.cmd[[colorscheme dracula]]

vim.api.nvim_create_autocmd('TermResponse', {
	once = true,
	callback = function ()
		vim.cmd('q')
	end
})
vim.api.nvim_buf_set_keymap(0, "n", "<leader>bc", "<cmd>te bacon<CR>", {noremap = true})
vim.api.nvim_buf_set_keymap(0, "n", "<leader>!", "<cmd>BaconLoad<CR><cmd>w<CR><cmd>BaconNext<CR>", {noremap = true})
vim.api.nvim_buf_set_keymap(0, "n", "<leader>bl", "<cmd>BaconList<CR>", {noremap = true})

require("ibl").setup()
mason = require("mason").setup()
require("mason-nvim-dap").setup()
require("neodev").setup({
    library = {plugins = {"nvim-dap-ui"}, types = true},
    ...
})
require("mason-lspconfig").setup()
require("mason-null-ls").setup()
require("dapui").setup()
Linters = {}
Mason_registry = require("mason-registry")
for _, pkg_info in ipairs(Mason_registry.get_installed_packages()) do
	for _, type in ipairs(pkg_info.spec.categories) do
		if type == "Linter" then
			Linters[#Linters+1] = pkg_info.name
		end
	end
end
require('lint').linters_by_ft = {markdown = {Linters}}
local null_ls = require("null-ls")
tempsource = {null_ls.builtins.completion.vsnip, null_ls.builtins.diagnostics.flake8, null_ls.builtins.diagnostics.alex}
local neogit = require('neogit')

null_ls.setup({
	sources = tempsource

})


require('lualine').setup{
	options={
		theme = 'dracula-nvim'
	}
}
if not vim.g.neovide then
    require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = {
            '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz',
            'zb'
        },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
        performance_mode = false -- Disable "Performance Mode" on all buffers.
    })
end
local dap, dapui = require("dap"), require("dapui")
local debugpy = Mason_registry.get_package("debugpy") -- note that this will error if you provide a non-existent package name
local masonDebugPath = debugpy:get_install_path() -- returns a string like "/home/user/.local/share/nvim/mason/packages/codelldb"
require('dap-python').setup(masonDebugPath .. "\\venv\\Scripts\\python", {})
dap.listeners.after.event_initialized["dapui_config"] =
    function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] =
    function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
-- Setup language servers.
local lspconfig = require('lspconfig')
local lspservers = {}
local masonconfig = require('mason-lspconfig')
for _, pkg_info in ipairs(Mason_registry.get_installed_packages()) do
	for _, type in ipairs(pkg_info.spec.categories) do
		if type == "LSP" then
			lspservers[#lspservers+1]=masonconfig.get_mappings().mason_to_lspconfig[pkg_info.name]
		end
	end
end

for _, lsp in ipairs(lspservers) do
    lspconfig[lsp].setup {capabilities = capabilities}
end
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = {buffer = ev.buf}
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder,
                       opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({'n', 'v'}, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f',
                       function() vim.lsp.buf.format {async = true} end, opts)
    end
})
require('swenv').setup({
    -- Should return a list of tables with a `name` and a `path` entry each.
    -- Gets the argument `venvs_path` set below.
    -- By default just lists the entries in `venvs_path`.
    get_venvs = function(venvs_path)
        return require('swenv.api').get_venvs(venvs_path)
    end,
    -- Path passed to `get_venvs`.
    venvs_path = vim.fn.expand('~/venvs'),
    -- Something to do after setting an environment, for example call vim.cmd.LspRestart
    post_set_venv = nil
})

-- nvim cmp config
local cmp = require 'cmp'

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.

            require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end
    },
    window = {
        --completion = cmp.config.window.bordered(),
        --documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        {name = 'nvim_lsp'}, {name = 'vsnip'}, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
       { name = 'snippy' }, -- For snippy users.
    }, {{name = 'buffer'}})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        {name = 'git'} -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {{name = 'buffer'}})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({'/', '?'}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{name = 'buffer'}}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.

-- linter autocommand
vim.api.nvim_create_autocmd({"BufWritePost"}, {
    callback = function() require("lint").try_lint() end
})
local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
    -- Enable or disable logging
    logging = true,
    -- Set the log level
    log_level = vim.log.levels.WARN,
    -- All formatter configurations are opt-in
    filetype = {
        -- Formatter configurations for filetype "lua" go here
        -- and will be executed in order
        lua = {
            -- "formatter.filetypes.lua" defines default configurations for the
            -- "lua" filetype
            require("formatter.filetypes.lua").stylua,

            -- You can also define your own configuration
            function()
                -- Supports conditional formatting
                if util.get_current_buffer_file_name() == "special.lua" then
                    return nil
                end

                -- Full specification of configurations is down below and in Vim help
                -- files
                return {
                    exe = "stylua",
                    args = {
                        "--search-parent-directories", "--stdin-filepath",
                        util.escape_path(util.get_current_buffer_file_path()),
                        "--", "-"
                    },
                    stdin = true
                }
            end
        },

        -- Use the special "*" filetype for defining formatter configurations on
        -- any filetype
        ["*"] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            require("formatter.filetypes.any").remove_trailing_whitespace
        }
    }
}
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
if vim.g.neovide then
    vim.g.neovide_theme = 'auto'
    vim.g.neovide_no_idle = true
    vim.o.guifont = "CaskaydiaCove Nerd Font" -- text below applies for VimScript
end
if vim.g.neovide then
    vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
    vim.keymap.set('v', '<D-c>', '"+y') -- Copy
    vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
    vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
    vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
    vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
end

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', {noremap = true, silent = true})
