-- Diagnostics
-- TODO(dk949): Make this work with ALE
vim.diagnostic.config {
    underline = true,
    virtual_lines = false, -- consider re-enabling
    update_in_insert = false,
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
}
