
require('telescope').setup {
  defaults = {
    prompt_prefix = "❯ ",
    selection_caret = "-> ",
    initial_mode = n,
    scroll_strategy = "limit",
    border = {},
    -- borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    borderchars = { '━', '┃', '━', '┃', '┏', '┓', '┛', '┗' },
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
    }
}

local th = require('telescope.themes')

function TeleConfig(str, mode)
    return require('telescope.builtin')[str](th.get_ivy({dir_icon = '❯', initial_mode = mode, sections = {"1","2","3"}}))
end
