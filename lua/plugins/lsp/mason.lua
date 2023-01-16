-- https://github.com/williamboman/mason.nvim
return {
    "williamboman/mason.nvim",
    as = "mason",
    config = function()
        require("mason").setup()
    end,
    after = "snip"
}
