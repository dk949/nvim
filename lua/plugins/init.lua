return {
    { "dk949/flatten.nvim",                  lazy = false, opts = require("config.plugins.flatten"),          priority = 1000, },
    { "nvim-tree/nvim-web-devicons",         lazy = true,  opts = {} },
    { 'stevearc/oil.nvim',                   lazy = false, opts = require("config.plugins.oil") },
    { "lewis6991/gitsigns.nvim",             lazy = false, opts = require("config.plugins.gitsigns") },
    { "godlygeek/tabular",                   lazy = true,  cmd = "Tabularize" },
    { "tpope/vim-surround",                  lazy = false, },
    { "lukas-reineke/indent-blankline.nvim", lazy = true,  opts = require("config.plugins.indent_blankline"), main = "ibl" },
    { import = "plugins.lsp" },
}
