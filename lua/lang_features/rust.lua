return {
    server = require("utils").lspSetupCreate("rust",
        function(capabilities, on_attach)
            require("lspconfig").rust_analyzer.setup {
                capabilities = capabilities,
                on_attach = on_attach,
                completion = { callSnippet = "Replace" },
                settings = {
                    codeLens = { enable = true },
                },
            }
        end
    ),
    masonInstall = "rust_analyzer"
}
