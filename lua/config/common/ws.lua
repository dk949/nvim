local M = {}
local utils = require("utils")
local log = require("utils.log")


function M.setup()
    if vim.b.no_trailing_ws then return "" end
    _, vim.b.no_trailing_ws = utils.withAugroup("whitespace",
        function(grp)
            return vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = vim.fn.bufnr(),
                group = grp,
                callback = function() if vim.b.no_trailing_ws then vim.cmd [[%s/\s\+$//e]] end end
            })
        end,
        { clear = true }
    )
    return [[call v:lua.require("config.common.ws").undo()]]
end

function M.undo()
    if not vim.b.no_trailing_ws then return end
    local ok, err = xpcall(vim.api.nvim_del_autocmd, debug.traceback, vim.b.no_trailing_ws)
    if not ok then log.warn(err) end
    vim.b.no_trailing_ws = nil
end

return M
