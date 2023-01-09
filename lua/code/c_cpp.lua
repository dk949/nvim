require("utils")

local ccls_setup = false
return function()
    if not dk949.lsp_loaded then return end

    if not ccls_setup then
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local lspconfig = require 'lspconfig'

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
            on_attach = nil,
            capabilities = capabilities,
        }
        ccls_setup = true
    end

    require("code.common")()
    localPlugins.format.addFmt([[:silent execute "!clang-format --style=file -i %"]], vim.fn.bufnr())
end
