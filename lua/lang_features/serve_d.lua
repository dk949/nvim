return {
    server = require("utils").lspSetupCreate("serve_d",
        function(capabilities, on_attach)
            local lspconfig = require("lspconfig")
            lspconfig.serve_d.setup {
                cmd = { "serve-d" },
                filetypes = { "d" },
                root_dir = lspconfig.util.root_pattern("dub.json", "dub.sdl", "*.d"),
                on_attach = on_attach,
                capabilities = capabilities,
            }
        end
    ),
    masonInstall = "serve_d"
}
