local utils = require("utils")
local ui = require("utils.ui")
local log = require("utils.log")
local M = {}

local function runInteractive(cmd, opts)
    if not opts then opts = {} end
    if opts.clear_env then log.warn("clear_env option does nothing when running git interactively") end
    ui.runInTerm(cmd)
end

local function runNonInteractive(cmd, opts)
    if not opts then opts = {} end
    return vim.system(cmd, { text = true, env = opts.env, clear_env = opts.clear_env }, function(out)
        local kind, val = nil, nil
        if out.code ~= 0 then
            kind = "code"
            val = out.code
        elseif out.signal ~= 0 then
            kind = "signal"
            val = out.signal
        else
            return
        end
        vim.schedule(function()
            log.error({
                { "Command ", utils.shellPrintFmt(cmd), " failed with " .. kind .. " ", val, ":" },
                { out.stderr }
            })
        end)
    end)
end

---Run git
---Executes command asynchronously
---If executing interactively, user manages when command completes, errors will
---be printed to the terminal.
---If executing non-interactively, runs asynchronously, errors are logged and
---`vim.SystemObj` is returned.
---Arguments in `cmd` will be automatically shell-escaped when needed.
---@param cmd string[]
---@param opts {interactive: boolean}
---@return unknown
function M.git(cmd, opts)
    cmd = vim.list_extend({ "git" }, cmd)
    if opts and opts.interactive then
        return runInteractive(cmd, opts)
    else
        return runNonInteractive(cmd, opts)
    end
end

return M
