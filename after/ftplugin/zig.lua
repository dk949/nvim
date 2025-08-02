require "utils".ftplugin(
    require "config.common".prog:with {
        formatprg = require("config.common.formatting").zigPrg,
    },
    function()
        local log = require("utils.log")
        vim.system({ "zig", "env" }, { text = true }, function(out)
            if out.code ~= 0 or out.signal ~= 0 then
                log.sched.warn("Couldn't load zig environment: ", out.stderr)
                return
            end
            ---@type boolean, table
            local succ, res = pcall(vim.json.decode, out.stdout)
            if not succ then
                log.sched.warnf("Could not decode zig env: '%s'", out.stdout)
                return
            end
            ---@type string?
            local std_dir = res.std_dir
            if not std_dir then
                log.warn("Failed to read std_dir from ", res)
                return
            end
            vim.g.zig_std_dir = std_dir
        end)

        require "utils.lsp".enableLsp({ config = "zls", mason = false })
    end
)
