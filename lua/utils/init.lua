local M = {}


---@param name string
---@param fn fun(grp: integer): nil
---@param opts {clear:boolean}?
---@return integer
function M.withAugroup(name, fn, opts)
    local clear = true
    if opts ~= nil and opts.clear ~= nil then clear = opts.clear end
    local grp = vim.api.nvim_create_augroup(name, { clear = clear })
    fn(grp)
    return grp
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

---@generic Arg, Ret
---@param val table<Arg, Ret>|fun(arg:Arg):Ret
---@param arg Arg
---@return Ret
function M.fnOrTable(val, arg)
    if type(val) == "function" then
        return val(arg)
    else
        return val[arg]
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
    for option, value in pairs(setlocal) do
        vim.opt_local[option] = value
        vim.b.undo_ftplugin = vim.b.undo_ftplugin .. " | setlocal " .. option .. '<'
    end
    if fn then fn() end
    vim.b[ftp_name] = true
    vim.b.undo_ftplugin = vim.b.undo_ftplugin .. " | unlet b:" .. ftp_name
end

return M
