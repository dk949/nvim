---@module "config.common.notes_comment"
local lazy = require("lazy")
local M = {}

M["@indentBlankline"] = function(yes)
    if not yes then return end
    return require "config.common.indent_blankline".setup()
end

M["@trailingWS"] = function(yes)
    if not yes then return end
    return require "config.common.ws".setup()
end

M["@logicalLines"] = function(yes)
    if not yes then return end
    return require("config.common.llines").setup()
end

---@param conf (boolean|("indent"|"incremental_selection"|"highlight")[])?
---@return string?
M["@treesitter"] = function(conf)
    if not conf then return end
    return require("config.common.treesitter").setup(conf)
end

---@param opts boolean|NotesComment.Opts?
---@return string?
M["@notesComment"] = function (opts)
    if not opts then return end
    if opts == true then opts = nil end
    return require("config.common.notes_comment").setup(vim.fn.bufnr(), opts)
end

return M
