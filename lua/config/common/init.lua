local format = require("config.common.format")
local utils = require("utils")

local M = {
    prog = utils.newWithTable {
        signcolumn = "yes",
        formatoptions = format.prog,
        colorcolumn = "+1",
        textwidth = 110,
        wrap = false,
        ["@indentBlankline"] = true,
        ["@trailingWS"] = true,
    },
    text = utils.newWithTable {
        formatoptions = format.text,
        textwidth = 80,
        wrap = true,
        linebreak = true,
        ["@trailingWS"] = true,
        ["@logicalLines"] = true,
    }
}

return M
