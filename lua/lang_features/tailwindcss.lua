return {
    server = require("utils").lspSetupCreate("tailwindcss",
        function(capabilities, on_attach)
            require("lspconfig").tailwindcss.setup {
                capabilities = capabilities,
                on_attach = on_attach,
                completion = { callSnippet = "Replace" }
            }
        end
    ),
    masonInstall = "tailwindcss"
}
