return {
    server = require("utils").lspSetupCreate("sumneko_lua",
        function(capabilities, on_attach)
            require("lspconfig").sumneko_lua.setup {
                capabilities = capabilities,
                on_attach = on_attach,
                completion = { callSnippet = "Replace" }
            }
        end
    ),
    masonInstall = "sumneko_lua"
}
