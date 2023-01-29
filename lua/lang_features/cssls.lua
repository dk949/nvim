return {
    server = require("utils").lspSetupCreate("cssls",
        function(capabilities, on_attach)
            local settings = {
                validate = false,
                unknownAtRules = "ignore",
            }
            require("lspconfig").cssls.setup {
                capabilities = capabilities,
                on_attach = on_attach,
                completion = { callSnippet = "Replace" },
                settings = {
                    css  = settings,
                    less = settings,
                    scss = settings,
                }
            }
        end
    ),
    masonInstall = "cssls"
}
