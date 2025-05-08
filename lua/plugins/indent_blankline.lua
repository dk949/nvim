-- https://github.com/lukas-reineke/indent-blankline.nvim
return {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        require("ibl").setup { scope = { enabled = true } }
    end,
}
