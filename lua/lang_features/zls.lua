return {
    server = require("utils").lspSetupCreate("zls",
        function(capabilities, on_attach)
            require("lspconfig").zls.setup {
                capabilities = capabilities,
                on_attach = on_attach,
            }
        end
    ),
    masonInstall = "zls"
}
