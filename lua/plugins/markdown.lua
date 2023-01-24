-- https://github.com/plasticboy/vim-markdown
return {
    "plasticboy/vim-markdown",
    ft = "markdown",
    config = function()
        vim.g.vim_markdown_auto_insert_bullets     = true
        vim.g.vim_markdown_folding_disabled        = true
        vim.g.vim_markdown_follow_anchor           = true
        vim.g.vim_markdown_new_list_item_indent    = 0
        vim.g.vim_markdown_no_default_key_mappings = false
        vim.g.vim_markdown_strikethrough           = true
    end,
}
