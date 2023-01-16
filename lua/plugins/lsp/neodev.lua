-- https://github.com/folke/neodev.nvim
return  {
    "folke/neodev.nvim",
    after = {"snip", "lspconfig" },
    config = function()
        require("neodev").setup({
            -- add any options here, or leave empty to use the default settings
        })
    end
}
