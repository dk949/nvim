return {
    server = require("utils").lspSetupCreate("cpp",
        function(capabilities, on_attach)
            local lspconfig = require("lspconfig")
            lspconfig.ccls.setup {
                cmd = { "ccls", "--log-file=/tmp/ccls.log", "-v=1" },
                filetypes = { "c", "cc", "cpp", "c++", "objc", "objcpp" },
                root_dir = lspconfig.util.root_pattern("CMakeLists.txt", ".ccls", "compile_commands.json"),
                init_options = {
                    cache = { directory = "/tmp/ccls" },
                    client = { snippetSupport = true },
                    index = { onChange = true },
                    highlight = { lsRanges = true }
                },
                on_attach = on_attach,
                capabilities = capabilities,
            }
        end
    ),
    masonInstall = nil
}
