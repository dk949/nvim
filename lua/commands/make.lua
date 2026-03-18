local log = require("utils.log")
local command = vim.api.nvim_create_user_command
---@type table<string, vim.SystemObj?>
local in_flight = {}
command("Make", function(arg)
    ---@type string
    local makeprg = vim.opt_local.makeprg:get()
    if makeprg:find([[\|]]) or makeprg:find('&') then
        log.warn("makeprg too complex: ", makeprg)
        return
    end
    local replaced = false
    local prog = vim.iter(vim.split(makeprg, " ", { plain = true, trimempty = true }))
        :map(function(p)
            if p == "$*" then
                replaced = true
                return arg.fargs
            else
                return p
            end
        end)
        :flatten()
        :totable()
    if not replaced then
        prog = vim.list_extend(prog, arg.fargs)
    end

    local name = vim.fn.join(prog, "")
    if in_flight[name] then
        in_flight[name]:kill("sigterm")
    end

    in_flight[name] = vim.system(prog, nil, function(out)
        if out.signal == 0 then
            if out.code ~= 0 or out.signal ~= 0 then
                log.sched.error({ "Make error:", out.stderr })
            else
                log.sched.info("Make success!")
            end
        end
        in_flight[name] = nil
    end)
end, { nargs = "*" })
