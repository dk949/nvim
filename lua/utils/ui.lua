local utils = require("utils")
local M = {}

---@class OptDims
---@field row number?
---@field col number?
---@field width number?
---@field height number?
---@field resize_factor number?

--- Open a floating window, slightly nicer API than nvim_open_win
--- By default, the window is opened in the screen and occupies 56.25% of the area
--- (width and height scaled down by 75%).
---@param enter boolean -- should window be entered immediately
---@param dims OptDims? -- dimensions of the window
---@param win_opts vim.api.keyset.win_config? -- do not set dimension here, use `dims`
---@param buf_opts {listed: boolean?, scratch: boolean?}? -- buffer options, default: false, true
---@return integer, integer -- Window ID, Buffer ID
function M.openfloat(enter, dims, win_opts, buf_opts)
    if not dims then dims = {} end
    if not dims.resize_factor then dims.resize_factor = 0.75 end
    if not dims.width then dims.width = vim.go.columns * dims.resize_factor end
    if not dims.height then dims.height = vim.go.lines * dims.resize_factor end
    if not dims.col then dims.col = (vim.go.columns - dims.width) / 2 end
    if not dims.row then dims.row = (vim.go.lines - dims.height) / 2 end
    if not win_opts then win_opts = {} end
    if not buf_opts then buf_opts = {} end
    if not buf_opts.listed then buf_opts.listed = false end
    if not buf_opts.scratch then buf_opts.scratch = true end

    win_opts.width = math.floor(dims.width)
    win_opts.height = math.floor(dims.height)
    win_opts.col = dims.col
    win_opts.row = dims.row
    win_opts.relative = "editor"

    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, enter, win_opts)
    return win, buf
end

---Open a floating terminal and run a command in it
---@param cmd string|string[]
---@param opts {resize: number?}?
function M.runInTerm(cmd, opts)
    if not opts then opts = {} end
    if not opts.resize then opts.resize = 0.75 end
    M.openfloat(true, { resize_factor = opts.resize })
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
