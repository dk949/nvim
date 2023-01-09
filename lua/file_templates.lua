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
    api.nvim_buf_set_lines(0, 0, 0, false, lines)
end
augroup("HeaderFileGroupd", {
    BufNewFile = {
        pattern = {"*.h", "*.hpp"},
        callback = snippetHpp,
    },
})
