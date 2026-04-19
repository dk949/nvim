require "utils".ftplugin(
    require "config.common".prog:with({
        formatexpr = require("config.common.formatting").shExpr,
        ["@treesitter"] = { { "highlight" }, install = "bash" }
    })
)
