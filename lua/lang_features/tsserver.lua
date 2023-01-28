return {
    server = require("utils").lspSetupCreate("ts",
        function(capabilities, on_attach)
            require("lspconfig").tsserver.setup {
                capabilities = capabilities,
                on_attach = on_attach,
                completion = { callSnippet = "Replace" },
            }
        end
    ),
    masonInstall = "tsserver"
}
