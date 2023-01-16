-- https://github.com/Mofiqul/dracula.nvim
return {
    "Mofiqul/dracula.nvim",
    config = function()
        require("dracula").setup({
            show_end_of_buffer = false,
            transparent_bg = false,
            italic_comment = false,
        })
        -- vim.cmd[[colorscheme dracula]]
    end
}
