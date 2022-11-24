if not dk949.lsp_loaded then return end
local lspconfig = require'lspconfig'
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.zls.setup{
    cmd = {"zls"},
    filetypes = {"zig"},
capabilities = capabilities
}
