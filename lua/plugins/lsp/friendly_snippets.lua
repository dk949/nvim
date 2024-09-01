-- https://github.com/rafamadriz/friendly-snippets
return {
    "rafamadriz/friendly-snippets",
    after = { "snip" },
    config = function ()
        require("luasnip.loaders.from_vscode").lazy_load()
    end
}
