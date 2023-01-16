local fn = vim.fn
local api = vim.api
local function snippetHpp()
    local define_name = fn.substitute(fn.toupper(fn.expand("%:t")), [[\.]], '_', "g")
    local lines = {
        "#ifndef " .. define_name,
        "#define " .. define_name,
        "",
        "",
        "",
        "#endif // " .. define_name
    }
    api.nvim_buf_set_lines(0, 0, -1, false, lines)
    api.nvim_win_set_cursor(0, { 4, 0 })
end

api.nvim_create_autocmd("BufNewFile", {
    pattern = { "*.h", "*.hpp" },
    callback = snippetHpp,
})
