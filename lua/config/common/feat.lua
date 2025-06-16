local M = {}

M["@indentBlankline"] = function(yes)
    if not yes then return end
    _ = require("ibl")
end

return M
