require("utils")

local function default() return function() vim.lsp.buf.format() end end

local function addFmt(fnOrCMD, buf)
    if dk949.formatters == nil then dk949.formatters = {} end
    if type(fnOrCMD) == "function" then
        dk949.formatters[buf] = fnOrCMD
    elseif type(fnOrCMD) == "string" then
        dk949.formatters[buf] = function() vim.cmd(fnOrCMD) end
    else
        error("expected funciton of string")
    end
end

local function addFmtAutocmd(opts)
    assert(opts.name ~= nil)
    assert(opts.pattern ~= nil)
    assert(opts.fnOrCMD ~= nil)
    assert(opts.buf ~= nil)
    return augroup(opts.name, {
        FileType = {
            pattern = opts.pattern,
            callback = function() addFmt(opts.fnOrCMD, opts.buf) end,
        }
    })
end

local function getFmt(buf)
    if dk949.formatters == nil or dk949.formatters[buf] == nil then
        return function() end
    else
        return dk949.formatters[buf]
    end
end

local function callFmt(buf) getFmt(buf)() end

return {
    addFmt = addFmt,
    getFmt = getFmt,
    callFmt = callFmt,
    addFmtAutocmd = addFmtAutocmd,
    default = default
}
