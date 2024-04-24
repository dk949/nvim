-- https://github.com/stevearc/dressing.nvim

return {
    "stevearc/dressing.nvim",
    config = function()
        require("dressing").setup({
            select = {
                -- Set to false to disable the vim.ui.select implementation
                enabled = true,

                -- Priority list of preferred vim.select implementations
                backend = { "telescope", "nui", "builtin", "fzf" },

                -- Options for telescope selector
                -- These are passed into the telescope picker directly. Can be used like:
                -- telescope = require('telescope.themes').get_ivy({...})
                telescope = require('telescope.themes').get_dropdown({ initial_mode = "insert" }),
            },
        })
    end
}
