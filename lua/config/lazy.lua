-- Setup lazy.nvim
require("lazy").setup({
    rocks = { hererocks = true },
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { missing = true },
    -- automatically check for plugin updates
    checker = { enabled = true },
})
