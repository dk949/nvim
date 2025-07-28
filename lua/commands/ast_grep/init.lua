local log = require("utils.log")
local command = vim.api.nvim_create_user_command
local ast_grep = require("commands.ast_grep.utils")
command("Sg",
    function(opts)
        local buf = nil
        if opts.bang then buf = { '.' } end
        local split = ast_grep.splitInput(opts.args)
        local selector = nil
        local pattern = split[1]
        if #split == 2 then
            selector = split[2]
        elseif #split ~= 1 then
            log.error("Incorrect format for Sg: expected `:Sg <pattern> [@ <selector>]`")
            return
        end


        ast_grep.run(pattern, selector, buf, nil, true)
    end,
    { nargs = '+', bang = true }
)
