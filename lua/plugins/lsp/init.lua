local ft = vim.tbl_keys(require("lang_features").feat.lspconfig)
table.insert(ft, "lua")
return {
    {
        "L3MON4D3/LuaSnip",
        ft = ft,
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        }
    },
    { "hrsh7th/cmp-nvim-lsp",     ft = ft },
    { "saadparwaiz1/cmp_luasnip", ft = ft },
    { "hrsh7th/cmp-buffer",       ft = ft },
    { "hrsh7th/cmp-path",         ft = ft },
    { 'neovim/nvim-lspconfig',    lazy=false, },
    { "williamboman/mason.nvim",  ft = ft, opts = {
            ensure_installed = require("lang_features").feat.lspservers,
    } },
    {
        "williamboman/mason-lspconfig.nvim",
        ft = ft,
        opts = {
            -- ensure_installed = require("lang_features").feat.lspservers,
        }
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    { import = "plugins.lsp.nvim_cmp", ft = ft }
}
