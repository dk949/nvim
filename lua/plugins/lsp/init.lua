local ft = { "lua" }
return {
    { "neovim/nvim-lspconfig", lazy = false },
    { "mason-org/mason.nvim",  ft = ft,   opts = {} },
}
