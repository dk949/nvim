local utils = require("utils")
local keymap = require("config.keymap")
local M = {}


function M.setup()
    if vim.b.logical_lines then return end
    vim.b.logical_lines = true
    keymap.logical_lines:defaultApply(nil, vim.fn.bufnr())
    return [[call v:lua.require("config.common.llines").undo()]]
end

function M.undo()
    if not vim.b.logical_lines then return end
    keymap.logical_lines:cloneUnmapped():defaultApply()
    vim.b.logical_lines = nil
end

return M
