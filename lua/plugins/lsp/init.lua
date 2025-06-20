return {
    { "neovim/nvim-lspconfig", lazy = true },
    { "mason-org/mason.nvim",  lazy = true, opts = {} },
    {
        "L3MON4D3/LuaSnip",
        lazy = true,
        version = "v2.*",
        build = "make install_jsregexp",
        config = require("config.plugins.luasnip"),
        dependencies = { "rafamadriz/friendly-snippets" },
    },
    {
        "hrsh7th/nvim-cmp",
        lazy = true,
        config = require("config.plugins.cmp"),
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "saadparwaiz1/cmp_luasnip",
        }
    },
    { "folke/lazydev.nvim", ft = "lua", opts = require("config.plugins.lazydev").opts, cond = require("config.plugins.lazydev").cond }
}
