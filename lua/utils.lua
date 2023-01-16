-- Extended API
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
            return fnOrVal(stmt[on])
        else
            return sfnOrVal(tmt.__default)
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
    return function()
        if not setups[name] then
            fn()
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

return M
