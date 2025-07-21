require "utils".ftplugin(
    require "config.common".prog:with {
        makeprg = "lit -vv %",
        ["@indentBlankline"] = false,
    }
)
