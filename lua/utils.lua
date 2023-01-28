local M = {}

function M.wincmd(cmd)
    vim.cmd("wincmd " .. cmd)
end

function M.fnOrVal(val)
    if type(val) == 'function' then
        return val()
    else
        return val
    end
end

function M.stripString(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function M.openWindow(opts)
    if opts == nil then opts = {} end
    local vert = true
    local splitFn = "split"
    local listed = true
    local scartch = true
    if opts.vert ~= nil then vert = opts.vert end
    if opts.splitFn ~= nil then splitFn = opts.splitFn end
    if opts.listed ~= nil then listed = opts.listed end
    if opts.scartch ~= nil then scartch = opts.scartch end
    ---@diagnostic disable-next-line: cast-local-type
    if vert then vert = "vert " else vert = "" end

    vim.cmd(vert .. splitFn)
    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_create_buf(listed, scartch)
    vim.api.nvim_win_set_buf(win, buf)
    return win, buf
end

function M.switch(on)
    return function(stmt)
        if stmt[on] ~= nil then
            return M.fnOrVal(stmt[on])
        else
            return M.fnOrVal(stmt.__default)
        end
    end
end

-- Callback generation

-- TODO
function M.setter(opts)
    return function()
        for opt, val in pairs(opts) do
            vim.o[opt] = val
        end
    end
end

function M.cmdCB(cmd)
    return function()
        return vim.cmd(cmd)
    end
end

local setups = {}
--- create an lsp setup function
---@param name string|number name or ID of the server (has to be usnique
---@param fn function function which sets up the server. Will be ran once
---@return function
function M.lspSetupCreate(name, fn)
    return function(capabilities, on_attach)
        if not setups[name] then
            fn(capabilities, on_attach)
            vim.cmd [[:LspStart]]
            setups[name] = true
        end
    end
end

-- Printing

function M.hlPrint(hl, ...)
    local arg = { ... }
    local text = {}
    for i, v in ipairs(arg) do
        text[i] = ({ tostring(v), hl })
    end
    vim.api.nvim_echo(text, true, {})
end

function M.warnPrint(...)
    M.hlPrint("WarningMsg", ...)
end

function M.errPrint(...)
    M.hlPrint("ErrorMsg", ...)
end

function M.makeLocalRequire(mod1)
    return function(mod2) return require(mod1 .. '.' .. mod2) end
end

M.winsize = {}
M.winsize.Pos = 1
M.winsize.Neg = -1
function M.winsize.chWidth(dir, inc)
    vim.api.nvim_win_set_width(0, vim.api.nvim_win_get_width(0) + (inc * dir))
end

function M.winsize.chHeight(dir, inc)
    vim.api.nvim_win_set_height(0, vim.api.nvim_win_get_height(0) + (inc * dir))
end

function M.winsize.changeWindowSize(letter)
    local _ = M.winsize
    assert(type(letter) == "string" and #letter == 1, "expected letter to be a character")
    if vim.fn.winnr('$') <= 1 then return end

    local pos = vim.api.nvim_win_get_position(0)

    local winChange = M.switch(letter) {
        h = function() return (pos[2] == 0) and { _.chWidth, _.Neg } or { _.chWidth, _.Pos } end,
        j = function() return (pos[1] == 0) and { _.chHeight, _.Pos } or { _.chHeight, _.Neg } end,
        k = function() return (pos[1] == 0) and { _.chHeight, _.Neg } or { _.chHeight, _.Pos } end,
        l = function() return (pos[2] == 0) and { _.chWidth, _.Pos } or { _.chWidth, _.Neg } end,
    }
    winChange[1](winChange[2], dk949.winSzInc)
end

M.term = {}

function M.term.make()
    local w = vim.api.nvim_win_get_width(0)
    local h = vim.api.nvim_win_get_height(0)
    if (w <= h * 2) then -- correcting for character aspet ratio
        vim.cmd [[split]]
    else
        vim.cmd [[vert split]]
    end
    vim.cmd [[term]]
    vim.cmd [[startinsert]]
end

---
---@param cmd string|List
---@param opts { runner: "bang"|"system", silent: nil|boolean }|nil
---@return number,string|nil
function M.shRun(cmd, opts)
    if opts == nil then opts = {} end
    if opts.runner == nil then opts.runner = "bang" end
    local runnerFn = nil
    if opts.runner == "bang" then
        local runner = ""
        if opts.silent then runner = "silent " end
        runner = runner .. "execute \"!"
        if type(cmd) == "string" then
            runner = runner .. cmd
        elseif type(cmd) == "table" then
            runner = runner .. table.concat(cmd, " ")
        end
        runner = runner .. '"'
        runnerFn = function() vim.cmd(runner) end
    elseif opts.runner == "system" then
        runnerFn = function() return vim.fn.system(cmd) end
    end

    local res = runnerFn()
    if opts.silent then
        return vim.v.shell_error
    else
        return vim.v.shell_error, res
    end
end

--- Set color fot a highlight group
---@param group string
---@param params {ctermfg:number|string, ctermbg:number|string, cterm:string, guifg:string, guibg:string, guisp:string, gui:string}
function M.hi(group, params)
    assert(type(params) == "table", "Expected a table got " .. type(params))
    local arg = ""
    for key, value in pairs(params) do
        arg = arg .. " " .. tostring(key) .. '=' .. tostring(value)
    end

    vim.cmd("hi " .. group .. arg)
end

return M
