local M = {}

M["@indentBlankline"] = function(yes)
    if not yes then return "" end
    _ = require("ibl")
    return ""
end

M["@trailingWS"] = function(yes)
    if not yes then return "" end
    return require "config.common.ws".setup()
end

return M
