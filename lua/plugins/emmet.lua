-- https://github.com/mattn/emmet-vim
return { {
    "mattn/emmet-vim",
    init = function() vim.g.user_emmet_leader_key = '<C-B>' end,
    ft = { "html", "xml", "svg", "css", "javascriptreact", "typescriptreact", "mail", "templ" }
} }
