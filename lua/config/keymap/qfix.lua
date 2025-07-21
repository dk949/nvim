local M = {
    cnext = function()
        local succ = pcall(vim.cmd.cnext)
        if not succ then vim.cmd.cfirst() end
    end,
    cprev = function()
        local succ = pcall(vim.cmd.cprev)
        if not succ then vim.cmd.clast() end
    end,
    inQfix = function(fn)
        return function()
            fn()
            vim.cmd.wincmd('p')
        end
    end
}

return M
