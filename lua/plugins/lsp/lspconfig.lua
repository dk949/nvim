return {
    'neovim/nvim-lspconfig',
    after = { "snip", "cmp" },
    as = "lspconfig",
    config = function()
        vim.opt.signcolumn = "yes"
        dk949.lsp_loaded = true
    end,
}
