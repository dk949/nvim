local utils = require("utils")
local M = {}

---Open a floating terminal and run a command in it
---@param cmd string|string[]
---@param opts {relsize: number?}?
function M.runInTerm(cmd, opts)
    require("flatten").config.window.open = "current"
    if not opts then opts = {} end
    if not opts.relsize then opts.relsize = 0.75 end
    local buf = vim.api.nvim_create_buf(false, true)
    local width = vim.go.columns * opts.relsize
    local height = vim.go.lines * opts.relsize

    local col = (vim.go.columns - width) / 2
    local row = (vim.go.lines - height) / 2
    vim.api.nvim_open_win(buf, true,
        {
            relative = "editor",
            width    = math.floor(width),
            height   = math.floor(height),
            row      = row,
            col      = col
        })
    local real_cmd = nil
    if type(cmd) == "string" then
        real_cmd = cmd
    else
        real_cmd = utils.shellConcat(cmd)
    end

    vim.cmd.term(real_cmd)
end

function M.prompt(prompt, if_yes, opts)
    local format_item = nil
    if opts and opts.format_item then
        format_item = opts.format_item
    else
        format_item = function(i) return i end
    end
    vim.ui.select(
        { "yes", "no" },
        { prompt = prompt, format_item = format_item },
        function(choice) if choice == "yes" then if_yes() end end
    )
end

return M
