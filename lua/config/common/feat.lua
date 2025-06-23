local lazy = require("lazy")
local M = {}

M["@indentBlankline"] = function(yes)
    if not yes then return "" end
    lazy.load({ plugins = { "indent-blankline.nvim" } })
    return ""
end

M["@trailingWS"] = function(yes)
    if not yes then return "" end
    return require "config.common.ws".setup()
end

M["@logicalLines"] = function(yes)
    if not yes then return "" end
    return require("config.common.llines").setup()
end

return M
