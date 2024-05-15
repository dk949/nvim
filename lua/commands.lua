local api = vim.api
local utils = require("utils")

api.nvim_create_user_command("W", "w", {})
api.nvim_create_user_command("E", "e <args>", { complete = "file", nargs = 1 })

local function deleteView()
    local fn = vim.fn
    ---@diagnostic disable-next-line: param-type-mismatch; bufname can accept specific strings.
    local path = fn.fnamemodify(fn.bufname('%'), ':p')
    path = fn.substitute(path, '=', '==', 'g')
    if vim.env.HOME then path = fn.substitute(path, '^' .. vim.env.HOME, '~', '') end
    path = fn.substitute(path, '/', '=+', 'g') .. '='
    path = vim.o.viewdir .. "/" .. path
    fn.delete(path)
    print("Deleted ", path)
    dk949.nomkview = true
end

api.nvim_create_user_command("Delview", function() deleteView() end, {})

utils.addAbrev("delview", "Delview")

api.nvim_create_user_command("EchoHl",
    [[echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . '> lo<' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"]]
    , {}
)

local function dict(word)
    local fn = vim.fn
    local out = fn.system([[curl -s dict://dict.org/d:]] .. word .. [[ | awk '!/[0-9]/' | sed 's/\r//g']])
    assert(vim.v.shell_error == 0, "Could not submit request to dict.org")
    return out
end

api.nvim_create_user_command("Dict", function(cmd) print(dict(cmd.args)) end, { nargs = 1 })

api.nvim_create_user_command("GitAddPatch",
    function(_)
        local gitsigns = require('gitsigns')

        gitsigns.preview_hunk_inline()
        vim.defer_fn(
            function()
                vim.cmd [[mkview]]
                vim.ui.select(
                    { 'y', 'n' },
                    {
                        prompt = 'Stage this hunk?:',
                        format_item = function(item) return item end,
                    },
                    -- FIXME: add range<S-Del>
                    function(choice) if choice == 'y' then gitsigns.stage_hunk() end end
                )
            end,
            0.01
        )
    end,
    { nargs = 0 }
)

utils.addAbrev("gd", "rightbelow Gitsigns diffthis")
utils.addAbrev("gb", "Gitsigns toggle_current_line_blame")
utils.addAbrev("gap", "GitAddPatch")

utils.addAbrev("tb", "Tabularize /")

utils.addAbrev("topen", "Trouble")

utils.addAbrev("mak", "Make!")

local function printFile(mode)
    local name = vim.fn.expand("%:" .. mode)
    local pos = vim.fn.getpos('.')
    api.nvim_buf_set_text(0, pos[2] - 1, pos[3] - 1, pos[2] - 1, pos[3] - 1, { name })
end

-- :p		expand to full path
api.nvim_create_user_command("PrintFileFullName", function() printFile('p') end, { nargs = 0 })

-- :t		tail (last path component only)
api.nvim_create_user_command("PrintFileName", function() printFile('t') end, { nargs = 0 })

-- :h		head (last path component removed)
api.nvim_create_user_command("PrintFileDirAbs", function() printFile('p:h') end, { nargs = 0 })

-- :h		head (last path component removed)
api.nvim_create_user_command("PrintFileDirRel", function() printFile('h') end, { nargs = 0 })

-- hexedit
local hex_count = 0
api.nvim_create_user_command("HexOn",
    function()
        local w = vim.api.nvim_win_get_width(0)
        if w >= 124 then
            vim.cmd [[%!xxd -c 32]]
            hex_count = 32
        elseif w >= 68 then
            vim.cmd [[%!xxd -c 16]]
            hex_count = 16
        else
            vim.cmd [[%!xxd -c 8]]
            hex_count = 8
        end
    end
    , {}
)

api.nvim_create_user_command("HexOff",
    function()
        vim.cmd([[%!xxd -r -c ]] .. tostring(hex_count))
    end
    , {}
)
local function reportGit(code, kind, err)
    if code == 0 then
        print(kind .. " successful")
        return
    end
    utils.errPrint(kind .. " failed: " .. err)
end

local function runGit(...)
    local args = { "git", ... }
    return function()
        local gitErrors = ""
        vim.fn.jobstart(args, {
            on_stderr = function(err) gitErrors = gitErrors .. err end,
            on_exit = function(arg) reportGit(arg[2], args[1] .. " " .. args[2], gitErrors) end
        })
    end
end

local function runGitWithEditor(...)
    local args = { "git", ... }
    return function()
        utils.errPrint("Cannot use `runGitWithEditor` until nvim gains support for --remote-wait")
        -- require('termutils').addCurrentWin()
        -- local gitErrors = ""
        -- vim.fn.jobstart(args, {
        --     env = { GIT_EDITOR = 'nvr --remote-wait-silent --servername ' .. vim.v.servername },
        --     on_stderr = function(err) gitErrors = gitErrors .. err end,
        --     on_exit = function()
        --         reportGit(arg[2], args[1] .. " " .. args[2], gitErrors)
        --         require('termutils').removeCurrentWin()
        --     end,
        -- })
    end
end

local function gitCommit(opts)
    if opts.args == "" then
        runGitWithEditor("commit", "-v")()
    else
        runGit("commit", "-m", opts.args)()
    end
end

-- api.nvim_create_user_command("GitCommit", runGitWithEditor("commit", "-v"), { nargs = 1 })
api.nvim_create_user_command("GitCommit", gitCommit, { nargs = '?' })
api.nvim_create_user_command("GitCommitAmmend", runGitWithEditor("commit", "--amend", "-v"), {})
api.nvim_create_user_command("GitCommitAmmendNoEdit", runGit("commit", "--amend", "-v", "--no-edit"), {})

utils.addAbrev("gcm", "GitCommit")
utils.addAbrev("gca", "GitCommitAmmend")
utils.addAbrev("gcan", "GitCommitAmmendNoEdit")
