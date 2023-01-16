-- https://github.com/idanarye/vim-dutyl
return {
    "idanarye/vim-dutyl", ft = "d",
    config = function()
        vim.cmd [[DUDCDstartServer]] -- start dcd
        vim.g.dutyl_dontHandleFormat = true
        vim.g.dutyl_dontHandleFormat = true
        vim.g.dutyl_neverAddClosingParen = true
    end
}
