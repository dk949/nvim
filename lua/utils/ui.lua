local utils = require("utils")
local M = {}


---@alias RelativeTo "cursor" | "editor" | "laststatus" | "mouse" | "tabline" | "win"

---@class OptDims
---@field row number?
---@field col number?
---@field width number?
---@field height number?
---@field resize_factor number?

---@class Dims
---@field row number
---@field col number
---@field width integer
---@field height integer
---@field resize_factor number

---comment
---@param dims OptDims?
---@return Dims
local function defaultOptDims(dims)
    if not dims then dims = {} end
    if not dims.resize_factor then dims.resize_factor = 0.75 end
    if not dims.width then dims.width = vim.go.columns * dims.resize_factor end
    if not dims.height then dims.height = vim.go.lines * dims.resize_factor end
    if not dims.col then dims.col = (vim.go.columns - dims.width) / 2 end
    if not dims.row then dims.row = (vim.go.lines - dims.height) / 2 end
    dims.width = math.floor(dims.width)
    dims.height = math.floor(dims.height)
    ---@cast dims any -- lua_ls doesn't know all options are non-nil
    return dims
end

--- Create or return buffer
---@param buf_opts ({listed: boolean?, scratch: boolean?}|integer)?
---@return integer
local function makeBuf(buf_opts)
    if type(buf_opts) == "number" then return buf_opts end
    if not buf_opts then buf_opts = {} end
    if not buf_opts.listed then buf_opts.listed = false end
    if not buf_opts.scratch then buf_opts.scratch = true end
    return vim.api.nvim_create_buf(buf_opts.listed, buf_opts.scratch)
end

---@class WinShouldEnter: boolean

---@type WinShouldEnter
M.ENTER = true
---@type WinShouldEnter
M.NO_ENTER = true

--- Open a floating window, slightly nicer API than nvim_open_win
--- By default, the window is opened in the screen and occupies 56.25% of the area
--- (width and height scaled down by 75%).
---@param enter WinShouldEnter -- should window be entered immediately
---@param opt_dims OptDims? -- dimensions of the window
---@param win_opts vim.api.keyset.win_config? -- do not set dimension here, use `dims`
---@param buf_opts ({listed: boolean?, scratch: boolean?}|integer)? -- buffer options, default: {false, true}
---@return integer, integer -- Window ID, Buffer ID
function M.openFloat(enter, opt_dims, win_opts, buf_opts)
    local dims = defaultOptDims(opt_dims)
    if not win_opts then win_opts = {} end

    win_opts.width = dims.width
    win_opts.height = dims.height
    win_opts.col = dims.col
    win_opts.row = dims.row
    win_opts.relative = "editor"

    local buf = makeBuf(buf_opts)
    local win = vim.api.nvim_open_win(buf, enter, win_opts)
    return win, buf
end

---Make existing window into a floating window
---MUST NOT BE THE LAST WINDOW IN TABPAGE
---@param win integer
---@param relative_to RelativeTo?
---@param opt_dims OptDims?
function M.floatWin(win, relative_to, opt_dims)
    local dims = defaultOptDims(opt_dims)
    local config = {
        relative = relative_to or "editor",
        width = dims.width,
        height = dims.height,
        col = dims.col,
        row = dims.row,
    }

    vim.api.nvim_win_set_config(win, config)
end

---Open a floating terminal and run a command in it
---@param cmd string|string[]
---@param opts {resize: number?}?
function M.runInTerm(cmd, opts)
    if not opts then opts = {} end
    if not opts.resize then opts.resize = 0.75 end
    M.openFloat(M.ENTER, { resize_factor = opts.resize })
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
