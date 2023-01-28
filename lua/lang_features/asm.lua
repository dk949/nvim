return {
    server = require("utils").lspSetupCreate("asm_lsp",
        function(capabilities, on_attach)
            local lspconfig = require("lspconfig")
            lspconfig.ccls.asm_lsp {
                cmd = { "asm-lsp" },
                filetypes = { "asm", "s", "S", "nasm" },
                on_attach = on_attach,
                capabilities = capabilities,
            }
        end
    ),
    masonInstall = "asm_lsp"
}
