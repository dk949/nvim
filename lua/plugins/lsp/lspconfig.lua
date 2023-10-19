return {
    'neovim/nvim-lspconfig',
    after = { "snip", "cmp" },
    as = "lspconfig",
    config = function()
        local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        vim.opt.signcolumn = "yes"
        dk949.lsp_loaded = true
    end,
}
