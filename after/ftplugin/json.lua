require "utils".ftplugin(
    require "config.common".prog:with {
        signcolumn           = "no",
        colorcolumn          = vim.NIL,
        ["@indentBlankline"] = false,
        formatprg            = require("config.common.formatting").jsonPrg,
        tabstop              = 2,
        shiftwidth           = 2,
        softtabstop          = 2,
        expandtab            = true,
    }
)
