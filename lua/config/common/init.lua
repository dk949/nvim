local format = require("config.common.format")
local M = {
    prog = {
        signcolumn = "yes",
        formatoptions = format.prog,
        colorcolumn = "+1",
        textwidth = 110,
        wrap = false,
        ["@indentBlankline"] = true,
        ["@trailingWS"] = true,
    },
    text = {
        formatoptions = format.text,
        textwidth = 80,
        ["@trailingWS"] = true,
        ["@logicalLines"] = true,
    }
}

return M
