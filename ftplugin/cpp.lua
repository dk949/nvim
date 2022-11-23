if not dk949.lsp_loaded then return end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require'lspconfig'

lspconfig.ccls.setup {
    cmd =  {"ccls","--log-file=/tmp/ccls.log","-v=1"},
    filetypes = {"c","cc","cpp","c++","objc","objcpp"},
    init_options = {
        cache = {directory = "/tmp/ccls"},
        client = {snippetSupport = true},
        index = {onChange = true},
        highlight = {lsRanges = true}
    },
    on_attach = nil,
    capabilities = capabilities,
}

localPlugins.format.addFmt([[:silent execute "!clang-format --style=file -i %"]], vim.fn.bufnr())
