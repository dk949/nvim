-- https://github.com/stevearc/dressing.nvim

return {
    "stevearc/dressing.nvim",
    config = function()
        require("dressing").setup {
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
            input = {
                insert_only = false,

                win_options = {
                    -- Disable line wrapping
                    wrap = false,
                    -- Indicator for when text exceeds window
                    list = true,
                    listchars = "precedes:…,extends:…",
                    -- Increase this for more context when text scrolls off the window
                    sidescrolloff = 0,
                    number = false,
                },

                mappings = {
                    n = {
                        ["<Esc>"] = "Close",
                        ["<CR>"] = "Confirm",
                    },
                    i = {
                        ["<CR>"] = "Confirm",
                        ["<Up>"] = "HistoryPrev",
                        ["<Down>"] = "HistoryNext",
                    },
                },
            },
        }
    end
}
