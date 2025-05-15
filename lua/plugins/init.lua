return {
    { "nvim-tree/nvim-web-devicons", lazy = true,  opts = {} },
    { import = "plugins.lsp" },
    { 'stevearc/oil.nvim',           lazy = false, opts = require("config.plugins.oil") }
}
