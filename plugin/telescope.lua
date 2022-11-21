
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

bi = require('telescope.builtin')
th = require('telescope.themes')

function Ts(str, mode)
    return require('telescope.builtin')[str](th.get_ivy({dir_icon = '❯', initial_mode = mode}))
end


--
--
--
--
--
--
-- " Optional (unused)
-- nnoremap <leader>fuo0    <cmd>lua Ts("fd", i)<CR>
-- nnoremap <leader>fuo1    <cmd>lua Ts("symbols")<CR>
-- nnoremap <leader>fuo2    <cmd>lua Ts("treesitter")<CR>
--
--
-- " lsp (unused)
-- nnoremap <leader>ful0     <cmd>lua Ts("lsp_code_actions")<CR>
-- nnoremap <leader>ful1     <cmd>lua Ts("lsp_definitions")<CR>
-- nnoremap <leader>ful2     <cmd>lua Ts("lsp_document_diagnostics")<CR>
-- nnoremap <leader>ful3     <cmd>lua Ts("lsp_document_symbols")<CR>
-- nnoremap <leader>ful4     <cmd>lua Ts("lsp_dynamic_workspace_symbols")<CR>
-- nnoremap <leader>ful5     <cmd>lua Ts("lsp_implementations")<CR>
-- nnoremap <leader>ful6     <cmd>lua Ts("lsp_range_code_actions")<CR>
-- nnoremap <leader>ful7     <cmd>lua Ts("lsp_references")<CR>
-- nnoremap <leader>ful8     <cmd>lua Ts("lsp_type_definitions")<CR>
-- nnoremap <leader>ful9     <cmd>lua Ts("lsp_workspace_diagnostics")<CR>
-- nnoremap <leader>fulA     <cmd>lua Ts("lsp_workspace_symbols")<CR>
--
--
-- " Don't work :(
-- " nnoremap <leader>f     <cmd>lua Ts("man_pages")<CR>
