-- https://github.com/jackguo380/vim-lsp-cxx-highlight
return {
    "jackguo380/vim-lsp-cxx-highlight",
    ft = { "c", "cpp" },
    after = { "lspconfig" },
    config = function()
        vim.g.cpp_class_scope_highlight = 1
        vim.g.cpp_member_variable_highlight = 1
        vim.g.cpp_class_decl_highlight = 1
    end,
}
