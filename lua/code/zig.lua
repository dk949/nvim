local zls_setup = false

return function()
    if not dk949.lsp_loaded then return end
    if not zls_setup then
        local lspconfig = require'lspconfig'
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        lspconfig.zls.setup{
            cmd = {"zls"},
            filetypes = {"zig"},
            capabilities = capabilities
        }
        zls_setup = true
    end
    require("code.common")()
end
