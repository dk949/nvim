local log = require("utils.log")
local M = {}

function M.pythonExpr()
    local mode = vim.fn.mode():sub(1, 1)
    -- don't format if invoked by reaching 'textwidth'
    if mode == 'R' or mode == 'i' then return 0 end
    local start_end = string.format("%d-%d", vim.v.lnum, vim.v.lnum + vim.v.count - 1)
    vim.system({
        "black",
        vim.fn.expand("%"),
        "--no-color",
        "-q",
        "--line-ranges",
        start_end,
    }, {
        text = true,
        stderr = function(err, data)
            if err and err ~= "" then
                log.sched.fatal("An error occurred when formatting file with black: ", err)
            end
            if data and data ~= "" then
                log.sched.warn(data)
            end
        end
    }, vim.schedule_wrap(function() vim.cmd.edit() end)
    )
    return 0
end

return M
