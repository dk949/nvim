local log = require("utils.log")
local cut = require("commands.utils")
local command = vim.api.nvim_create_user_command
command("Make", function()
    vim.system({"make"}, {}, function (out)
        if out.code ~= 0 or out.signal ~= 0 then
            log.sched.error({"Make error:", out.stderr})
        else
            log.sched.info("Make success!")
        end
    end)
end, {})
