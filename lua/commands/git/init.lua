local git = require("commands.git.utils")
local ui = require("utils.ui")
local command = vim.api.nvim_create_user_command
local gs = require("gitsigns")

command("GitAddPatch",
    function(opts)
        gs.preview_hunk_inline(function()
            vim.defer_fn(function()
                    ui.prompt("Stage this hunk?", function()
                        local range = nil
                        if opts.range ~= 0 then
                            range = { opts.line1, opts.line2 }
                        end
                        gs.stage_hunk(range)
                    end)
                end,
                0.01)
        end)
    end,
    { nargs = 0, range = true }
)


command("GitCommit", function(opts)
    if opts.args == "" then
        git.git({"commit"}, {interactive = true})
    else
        git.git({"commit", "-m", opts.args}, {interactive = false})
    end
end, { nargs = '*' })
