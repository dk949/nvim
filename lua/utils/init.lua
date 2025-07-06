local comm_ut = require("config.common.utils")
local M = {}

---Binary string
---@param s string
---@return integer
function M.b(s) return tonumber(s, 2) end

---Octal string
---@param s string
---@return integer
function M.o(s) return tonumber(s, 8) end

---@param name string
---@param fn fun(grp: integer): integer
---@param opts {clear:boolean}?
---@return integer, integer
function M.withAugroup(name, fn, opts)
    local clear = true
    if opts ~= nil and opts.clear ~= nil then clear = opts.clear end
    local grp = vim.api.nvim_create_augroup(name, { clear = clear })
    return grp, fn(grp)
end

---Restores cursor position after any movement
---**Caller must handle jumplist**
---@param fn fun():nil
function M.withCursor(fn)
    local old = vim.fn.getcurpos()
    fn()
    vim.fn.setpos('.', old)
end

---Like `withCursor`, but also preserves window position
---@param fn fun():nil
function M.withWin(fn)
    local old = vim.fn.winsaveview()
    fn()
    vim.fn.winrestview(old)
end

---@param val any
---@return any
function M.fnOrVal(val, ...)
    if type(val) == 'function' then
        return val(...)
    else
        return val
    end
end

---@generic Args, Ret
---@param val table<Args, Ret>|fun(arg:Args):Ret
---@param ... Args
---@return Ret
function M.fnOrTable(val, ...)
    if type(val) == "function" then
        return val(...)
    else
        return val[...]
    end
end

---@param on any
---@return fun(_:table):any
function M.switch(on)
    return function(stmt)
        if stmt[on] ~= nil then
            return M.fnOrVal(stmt[on], on)
        else
            for k, v in pairs(stmt) do
                if type(k) == "table" and vim.islist(k) then
                    for _, option in ipairs(k) do
                        if option == on then
                            return M.fnOrVal(v, option)
                        end
                    end
                end
            end
            return M.fnOrVal(stmt.__default, on)
        end
    end
end

---Helper function for use in after/ftplugin files
---@param setlocal table<string, any>
---@param fn (fun():nil)|nil
function M.ftplugin(setlocal, fn)
    local ftp_name = "ftp_" .. vim.bo.filetype
    if vim.b[ftp_name] then return end
    local settings, undo = comm_ut.setAll(vim.deepcopy(setlocal))
    if not vim.b.undo_ftplugin then vim.b.undo_ftplugin = "" end
    vim.b.undo_ftplugin = vim.b.undo_ftplugin .. undo
    for option, value in pairs(settings) do
        vim.opt_local[option] = value
        vim.b.undo_ftplugin = vim.b.undo_ftplugin .. " | setlocal " .. option .. '<'
    end
    if fn then fn() end
    vim.b[ftp_name] = true
    -- TODO(dk949): Figure out why this is getting added to undo_ftplugin twice
    local unlet = " | unlet b:" .. ftp_name
    if not vim.b.undo_ftplugin:find(unlet, 1, true) then
        vim.b.undo_ftplugin = vim.b.undo_ftplugin .. unlet
    end
end

local shell_chars = '[|&;<>%(%)%$%`\\%*%?%[%]%{%}%~ \t\n"\']'

---Formats a shell command from list for *printing*
---**NOT TO BE USED AS ACTUAL SHELL INPUT**
---**USE `shellConcat` INSTEAD**
---@param cmd string[]
---@return string
function M.shellPrintFmt(cmd)
    assert(vim.islist(cmd))
    return vim.iter(cmd)
        :map(function(arg)
            if arg ~= "" and arg:find(shell_chars) == nil then
                return arg
            else
                return vim.fn.shellescape(arg)
            end
        end)
        :join(' ')
end

---Concatenate `cmd` such that it is safe to use as shell input
---Not very pretty, but functional
---Use `shellPrintFmt` for "pretty"
---@param cmd string[]
---@param opts {special: boolean}
---@return string
function M.shellConcat(cmd, opts)
    local special = nil
    if opts and opts.special then special = true end
    return vim.iter(cmd)
        :map(function(c) return vim.fn.shellescape(c, special) end)
        :join(' ')
end

return M
