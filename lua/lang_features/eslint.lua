return {
    server = require("utils").lspSetupCreate("eslint",
        function(capabilities, on_attach)
            local lspconfig = require("lspconfig")
            lspconfig.eslint.setup {
                capabilities = capabilities,
                on_attach = on_attach,
                completion = { callSnippet = "Replace" },
                settings = { packageManager = "npm" },
                root_dir = lspconfig.util.root_pattern('package.json'),
            }
        end
    ),
    masonInstall = "eslint"
}
