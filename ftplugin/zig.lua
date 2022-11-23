if not dk949.lsp_loaded then return end
local lspconfig = require'lspconfig'

lspconfig.zls.setup{
    cmd = {"zls"},
    filetypes = {"zig"}
}
