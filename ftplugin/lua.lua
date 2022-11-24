if not dk949.lsp_loaded then return end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require'lspconfig'

lspconfig.sumneko_lua.setup {
    capabilities = capabilities
}

localPlugins.format.addFmt(localPlugins.format.default, vim.fn.bufnr())
