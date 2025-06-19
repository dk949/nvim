
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
}
