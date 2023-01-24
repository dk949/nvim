return {
    server = require("utils").lspSetupCreate("python",
        function(capabilities, on_attach)
            require("lspconfig").pyright.setup {
                capabilities = capabilities,
                on_attach = on_attach,
            }
        end
    ),
    masonInstall = "pyright"
}
