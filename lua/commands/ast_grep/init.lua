local command = vim.api.nvim_create_user_command
local ast_grep = require("commands.ast_grep.utils").ast_grep
command("Sg",
    function(opts)
        local buf = nil
        if opts.bang then buf = {'.'} end
        ast_grep(opts.args, buf)
    end,
    { nargs = '*', bang = true }
)
