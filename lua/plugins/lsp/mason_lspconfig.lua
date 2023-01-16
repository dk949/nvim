-- https://github.com/williamboman/mason-lspconfig.nvim
return {
    "williamboman/mason-lspconfig.nvim",
    after = { "mason", "lspconfig" },
    as = "mason-lsp",
    config = function()
        require("mason-lspconfig").setup {
            ensure_installed = { "sumneko_lua", "serve_d", "hls" },
        }
    end,
    after = "snip"

}
