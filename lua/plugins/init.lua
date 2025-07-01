return {
    {
        "dk949/flatten.nvim",
        lazy = false,
        opts = require("config.plugins.flatten"),
        priority = 1000,
    },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        opts = {}
    },
    {
        'stevearc/oil.nvim',
        lazy = false,
        opts = require("config.plugins.oil")
    },
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        opts = require("config.plugins.gitsigns")
    },
    {
        "godlygeek/tabular",
        lazy = true,
        cmd = "Tabularize"
    },
    {
        "tpope/vim-surround",
        lazy = false,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        lazy = true,
        opts = require("config.plugins.indent_blankline"),
        main = "ibl"
    },
    {
        "nvim-telescope/telescope.nvim",
        lazy = true,
        opts = require("config.plugins.telescope"),
        cmd = "Telescope"
    },
    {
        "dk949/telescope-oil-columns",
        lazy = true
    },
    {
        dir = "~/src/mlir-vim/mlir/utils/vim",
        name = "mlir-vim",
        ft = "mlir"
    },
    {
        dir = "~/src/mlir-vim/llvm/utils/vim",
        name = "tablegen-vim",
    },
    {
        "bullets-vim/bullets.vim",
        ft = "markdown"
    },
    { import = "plugins.lsp" },
}
