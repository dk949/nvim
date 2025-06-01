return {
    { "nvim-tree/nvim-web-devicons", lazy = true,  opts = {} },
    { import = "plugins.lsp" },
    { 'stevearc/oil.nvim',           lazy = false, opts = require("config.plugins.oil") },
    { "lewis6991/gitsigns.nvim",     lazy = false, opts = require("config.plugins.gitsigns") },
    { "willothy/flatten.nvim",       lazy = false, opts = require("config.plugins.flatten"), priority = 1000, },
    { "godlygeek/tabular",           lazy = true , cmd="Tabularize"},
}
