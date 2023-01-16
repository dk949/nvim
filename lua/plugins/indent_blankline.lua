-- https://github.com/lukas-reineke/indent-blankline.nvim
return {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        vim.opt.termguicolors = true
        vim.g.indent_blankline_char_list = {'|', '¦', '┆', '┊'}
    end
}
