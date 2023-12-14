-- https://github.com/plasticboy/vim-markdown
return {
    "plasticboy/vim-markdown",
    ft = "markdown",
    config = function()
        vim.g.vim_markdown_new_list_item_indent    = 0
        vim.opt_local.conceallevel                 = 2

        vim.g.vim_markdown_auto_insert_bullets     = true
        vim.g.vim_markdown_folding_disabled        = true
        vim.g.vim_markdown_follow_anchor           = true
        vim.g.vim_markdown_no_default_key_mappings = false
        vim.g.vim_markdown_strikethrough           = true
        vim.g.vim_markdown_toc_autofit             = true
        vim.g.vim_markdown_emphasis_multiline      = false
        vim.g.vim_markdown_math                    = true
        vim.g.vim_markdown_conceal_code_blocks     = true
        vim.g.vim_markdown_follow_anchor           = true
        vim.g.vim_markdown_strikethrough           = true
        vim.g.vim_markdown_conceal_code_blocks     = false
    end,
}
