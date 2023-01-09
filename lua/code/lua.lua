local lua_lsp_setup = false

return function()
    if not dk949.lsp_loaded then return end
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    if not lua_lsp_setup then
        local lspconfig = require 'lspconfig'

        lspconfig.sumneko_lua.setup {
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim', "dk949" }
                    }
                }
            }
        }
        lua_lsp_setup = true
    end

    require("code.common")()
    localPlugins.format.addFmt(function() vim.lsp.buf.format() end, vim.fn.bufnr())
end
