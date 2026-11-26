return {
    lsp = {
        auto_attach = true, -- register LspAttach autocmd
        -- navic attaches to one client per buffer; prefer these if several provide documentSymbol
        preference = { "clangd", "rust_analyzer", "basedpyright", "zls" },
    },
    highlight = true,
    separator = "  ",
    depth_limit = 0,
    depth_limit_indicator = "…",
    lazy_update_context = false, -- don't update the context on CursorMoved
    click = true,
}
