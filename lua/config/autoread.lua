local ut = require("utils")
local log = require("utils.log")
local M = {}

local function checktime()
    if vim.fn.mode() == "n" and vim.fn.getcmdwintype() == "" then
        ut.withWin(function() vim.cmd("silent! checktime") end)
    end
end

function M.setup()
    local timer, err = vim.uv.new_timer()
    if timer == nil then
        log.warn("Could not create a timer:", err)
        return
    end
    timer:start(vim.o.updatetime, vim.o.updatetime, vim.schedule_wrap(checktime))

    ut.withAugroup("Dk949Autoread", function(grp)
        return vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
            callback = checktime,
            group = grp,
        })
    end)
end

return M
