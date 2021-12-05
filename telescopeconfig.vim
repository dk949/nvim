" things that have to be configured through lua

lua << EOF
i = "insert"
n = "normal"

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

EOF


" mappings



" telescope
nnoremap <leader>f     <cmd>lua Ts("builtin")<CR>
nnoremap <leader>ftl   <cmd>lua Ts("reloader")<CR>
nnoremap <leader>ftp   <cmd>lua Ts("pickers", i)<CR>
nnoremap <leader>ftr   <cmd>lua Ts("resume")<CR>
nnoremap <leader>ftup  <cmd>lua Ts("planets")<CR>


" Tags
nnoremap <leader>ftac    <cmd>lua Ts("current_buffer_tags", n)<CR>
nnoremap <leader>ftas    <cmd>lua Ts("tagstack", n)<CR>
nnoremap <leader>ftat    <cmd>lua Ts("tags", n)<CR>


" file
nnoremap <leader>ff/    <cmd>lua Ts("current_buffer_fuzzy_find", i)<CR>
nnoremap <leader>ffb    <cmd>lua Ts("buffers", n)<CR>
nnoremap <leader>fff    <cmd>lua Ts("find_files", i)<CR>
nnoremap <leader>ffn    <cmd>lua Ts("file_browser", n)<CR>
nnoremap <leader>ffo    <cmd>lua Ts("oldfiles", n)<CR>
nnoremap <leader>ffr    <cmd>lua Ts("live_grep", i)<CR>


" misc
nnoremap <leader>fmj    <cmd>lua Ts("jumplist", n)<CR>
nnoremap <leader>fml    <cmd>lua Ts("loclist", n)<CR>
nnoremap <leader>fmm    <cmd>lua Ts("marks", n)<CR>
nnoremap <leader>fmq    <cmd>lua Ts("quickfix", n)<CR>


" vim
nnoremap <leader>fva    <cmd>lua Ts("autocommands", n)<CR>
nnoremap <leader>fvch   <cmd>lua Ts("command_history", n)<CR>
nnoremap <leader>fvcl   <cmd>lua Ts("colorscheme", n)<CR>
nnoremap <leader>fvcm   <cmd>lua Ts("commands", n)<CR>
nnoremap <leader>fvf    <cmd>lua Ts("filetypes", i)<CR>
nnoremap <leader>fvhi   <cmd>lua Ts("highlights", n)<CR>
nnoremap <leader>fvhl   <cmd>lua Ts("help_tags", i)<CR>
nnoremap <leader>fvk    <cmd>lua Ts("keymaps", n)<CR>
nnoremap <leader>fvo    <cmd>lua Ts("vim_options", n)<CR>
nnoremap <leader>fvr    <cmd>lua Ts("registers", n)<CR>
nnoremap <leader>fvsh   <cmd>lua Ts("search_history", n)<CR>
nnoremap <leader>fvss   <cmd>lua Ts("spell_suggest", n)<CR>


" Git
nnoremap <leader>fgb    <cmd>lua Ts("git_branches", n)<CR>
nnoremap <leader>fgc    <cmd>lua Ts("git_commits", n)<CR>
nnoremap <leader>fgf    <cmd>lua Ts("git_files", n)<CR>
nnoremap <leader>fglb   <cmd>lua Ts("git_bcommits", n)<CR>
nnoremap <leader>fgs    <cmd>lua Ts("git_stash", n)<CR>
nnoremap <leader>fgv    <cmd>lua Ts("git_status", n)<CR>


" Optional (unused)
nnoremap <leader>fuo0    <cmd>lua Ts("fd", i)<CR>
nnoremap <leader>fuo1    <cmd>lua Ts("symbols")<CR>
nnoremap <leader>fuo2    <cmd>lua Ts("treesitter")<CR>


" lsp (unused)
nnoremap <leader>ful0     <cmd>lua Ts("lsp_code_actions")<CR>
nnoremap <leader>ful1     <cmd>lua Ts("lsp_definitions")<CR>
nnoremap <leader>ful2     <cmd>lua Ts("lsp_document_diagnostics")<CR>
nnoremap <leader>ful3     <cmd>lua Ts("lsp_document_symbols")<CR>
nnoremap <leader>ful4     <cmd>lua Ts("lsp_dynamic_workspace_symbols")<CR>
nnoremap <leader>ful5     <cmd>lua Ts("lsp_implementations")<CR>
nnoremap <leader>ful6     <cmd>lua Ts("lsp_range_code_actions")<CR>
nnoremap <leader>ful7     <cmd>lua Ts("lsp_references")<CR>
nnoremap <leader>ful8     <cmd>lua Ts("lsp_type_definitions")<CR>
nnoremap <leader>ful9     <cmd>lua Ts("lsp_workspace_diagnostics")<CR>
nnoremap <leader>fulA     <cmd>lua Ts("lsp_workspace_symbols")<CR>


" Don't work :(
" nnoremap <leader>f     <cmd>lua Ts("man_pages")<CR>
