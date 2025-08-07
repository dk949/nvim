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
        "dk949/telescope-oil-columns",
        lazy = true
    },
    {
        "refractalize/oil-git-status.nvim",
        config = require("config.plugins.oil_git_status")
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
    {
        "dk949/remember-where",
        lazy = false,
        config = require("config.plugins.remember-where"),
    },
    {
        "catgoose/nvim-colorizer.lua",
        ft = { "css", "html" },
        cmd = { "ColorizerAttachToBuffer", "ColorizerToggle" },
        opts = require("config.plugins.colorizer"),
    },
    {
        "RaafatTurki/hex.nvim",
        cmd = { "HexDump", "HexAssemble", "HexToggle" },
        opts = require("config.plugins.hex"),
    },
    {
        "dk949/ast-search.nvim",
        opts = {},
        cmd = "Sg",
    },
    {
        "puremourning/vimspector",
        keys = {
            { "<F5>", ft = { "cpp", "c", "python" } },
            { "<F9>", ft = { "cpp", "c", "python" } }
        },
        init = require("config.plugins.vimspector"),
    },
    {
        "dk949/file_line.nvim",
        main = "file_line",
        opts = require("config.plugins.file_line"),
        lazy = false,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = 'master',
        lazy = false,
        cmd = { "TSBufEnable", "TSEnable" },
        build = ":TSUpdate",
        config = require("config.plugins.treesitter"),
    },
    {
        "nvim-neorg/neorg",
        event = { "BufRead *.norg", "BufNewFile *.norg", "User Dk949Args0" },
        cmd = "Neorg",
        version = "*",
        opts = require("config.plugins.neorg"),
    },
    {
        "3rd/image.nvim",
        ft = { "norg", "markdown" },
        event = {"BufRead *.jpg,*.png", "BufNewFile *.jpg,*.png", },
        opts = require("config.plugins.image"),
    },
    { import = "plugins.lsp" },
}
