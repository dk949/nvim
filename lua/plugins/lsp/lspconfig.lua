return {
    'neovim/nvim-lspconfig',
    after = { "snip", "cmp" },
    as = "lspconfig",
    config = function()
        vim.diagnostic.config({
            signs = {
                text  = {
                    [vim.diagnostic.severity.ERROR] = "󰅚 ",
                    [vim.diagnostic.severity.WARN] = "󰀪 ",
                    [vim.diagnostic.severity.INFO] = " ",
                    [vim.diagnostic.severity.HINT] = "󰌶 ",
                },
                numhl = {
                    [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                    [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
                    [vim.diagnostic.severity.INFO]  = "DiagnosticSignHint",
                    [vim.diagnostic.severity.HINT]  = "DiagnosticSignInfo",
                },
            }
        })

        vim.opt.signcolumn = "yes"
        dk949.lsp_loaded = true
    end,
}
