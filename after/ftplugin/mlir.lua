require "utils".ftplugin(
    vim.tbl_deep_extend("force", require "config.common".prog, {
        ["@indentBlankline"] = false,
    })
)
