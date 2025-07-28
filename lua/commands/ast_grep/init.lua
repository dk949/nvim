local command = vim.api.nvim_create_user_command
local run = require("commands.ast_grep.utils").run
command("Sg",
    function(opts)
        local buf = nil
        if opts.bang then buf = { '.' } end
        run(opts.args, nil, buf, nil, true)
    end,
    { nargs = '*', bang = true }
)
