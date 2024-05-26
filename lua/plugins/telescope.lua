-- https://github.com/nvim-telescope/telescope.nvim

return {
    "nvim-telescope/telescope.nvim",
    config = function()
        require('telescope').setup {
            defaults = {
                prompt_prefix = "❯ ",
                selection_caret = "-> ",
                initial_mode = 'normal',
                scroll_strategy = "limit",
                border = {},
                borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
                -- borderchars = { '━', '┃', '━', '┃', '┏', '┓', '┛', '┗' },
                -- borderchars = { '═', '║', '═', '║', '╔', '╗', '╝', '╚' },
                find_files = {
                    theme = "dropdown"
                },
                mappings = {
                    i = {
                        ["<c-b>"] = "preview_scrolling_down",
                        ["<c-f>"] = "preview_scrolling_up",
                    },
                    n = {
                        ["<c-b>"] = "preview_scrolling_down",
                        ["<c-f>"] = "preview_scrolling_up",
                        ["v"] = "file_vsplit",
                        ["t"] = "file_tab",
                        ["ZZ"] = "close",
                    },
                },
            },
            pickers = {
                find_files = {
                    find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
                },
            }
        }
    end
}
