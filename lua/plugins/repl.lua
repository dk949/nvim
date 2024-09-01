return {
    "dk949/repl-nvim",
    config = function()
        require("repl-nvim").setup({
            configs = {
                elixir = { open = { "iex", "-S", "mix" }, refresh = "recompile" }
            }
        })
    end
}
