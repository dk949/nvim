return require("utils").lspSetupCreate("lua",
    function(capabilities, on_attach)
        require("lspconfig").sumneko_lua.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            completion = { callSnippet = "Replace" }
        }
    end
)
