return {
    server = require("utils").lspSetupCreate("css",
        function(capabilities, on_attach)
            require("lspconfig").cssls.setup {
                capabilities = capabilities,
                on_attach = on_attach,
                completion = { callSnippet = "Replace" }
            }
        end
    ),
    masonInstall = "cssls"
}
