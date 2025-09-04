local log = require("utils.log")
local command = vim.api.nvim_create_user_command
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

    vim.system(prog, nil, function(out)
        if out.code ~= 0 or out.signal ~= 0 then
            log.sched.error({ "Make error:", out.stderr })
        else
            log.sched.info("Make success!")
        end
    end)
end, { nargs = "*" })
