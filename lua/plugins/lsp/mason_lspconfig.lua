-- https://github.com/williamboman/mason-lspconfig.nvim
return {
    "williamboman/mason-lspconfig.nvim",
    after = { "snip", "mason", "lspconfig" },
    as = "mason-lsp",
    config = function()
        require("mason-lspconfig").setup {
            ensure_installed = require("lang_features").feat.lspservers,
        }
    end,
}
