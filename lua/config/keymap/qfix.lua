local log = require("utils.log")
local M = {
    cnext = function()
        local succ = pcall(vim.cmd.cnext)
        if succ then return end
        succ = pcall(vim.cmd.cfirst)
        if not succ then log.warn("No quickfix items") end
    end,
    cprev = function()
        local succ = pcall(vim.cmd.cprev)
        if succ then return end
        succ = pcall(vim.cmd.clast)
        if not succ then log.warn("No quickfix items") end
    end,
    inQfix = function(fn)
        return function()
            fn()
            vim.cmd.wincmd('p')
        end
    end
}

return M
