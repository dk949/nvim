return {
    server = require("utils").lspSetupCreate("html",
        function(capabilities, on_attach)
            require("lspconfig").html.setup {
                capabilities = capabilities,
                on_attach = on_attach,
                completion = { callSnippet = "Replace" }
            }
        end
    ),
    masonInstall = "html"
}
