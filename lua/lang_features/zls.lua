vim.g.zig_fmt_parse_errors = false

vim.api.nvim_create_autocmd("LspAttach", {
    pattern = "*",
    callback = function() vim.api.nvim_set_hl(0, '@lsp.type.comment.zig', {}) end
});
return require("utils").makeDefaultLspCounfig("zls", {
    install = false,
    settings = {
        enable_inlay_hints = true
    },
})
