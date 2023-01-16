local api = vim.api
local fn = vim.fn

api.nvim_create_user_command("W", "w", {})
api.nvim_create_user_command("E", "e", {})

local function deleteView()
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

-- Lower-case user commands: http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
vim.cmd [[cabbrev delview <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Delview' : 'delview')<CR>]]

api.nvim_create_user_command("EchoHl",
    [[echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . '> lo<' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"]]
    , {}
)

local function dict(word)
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

vim.cmd [[cabbrev gd rightbelow Gitsigns diffthis]]
vim.cmd [[cabbrev gb Gitsigns toggle_current_line_blame]]
vim.cmd [[cabbrev gap GitAddPatch]]

vim.cmd [[cabbrev tb Tabularize /]]

vim.cmd [[cabbrev topen Trouble]]
