return {
    server = require("utils").lspSetupCreate("asm",
        function(capabilities, on_attach)
            local lspconfig = require("lspconfig")
            lspconfig.ccls.setup {
                cmd = { "asm-lsp" },
                filetypes = { "asm", "s", "S" },
                root_dir = lspconfig.util.root_pattern("CMakeLists.txt", ".ccls", "compile_commands.json"),
                on_attach = on_attach,
                capabilities = capabilities,
            }
        end
    ),
    masonInstall = nil
}
