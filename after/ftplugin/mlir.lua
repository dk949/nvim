require "utils".ftplugin(
    require "config.common".prog:with {
        makeprg = "lit -vv %",
        signcolumn = "no",
        colorcolumn = vim.NIL,
        ["@indentBlankline"] = false,
    }
)
