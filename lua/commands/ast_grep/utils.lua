local log = require("utils.log")
---@alias BufSpec (integer|string)[]


---@class ast_grep.Position
---@field line integer # zero-based line number
---@field column integer # zero-based column number

---@class ast_grep.ByteOffset
---@field start integer # start is inclusive
---@field end integer   # end is exclusive

---@class ast_grep.Range
---@field byteOffset ast_grep.ByteOffset
---@field start ast_grep.Position
---@field end ast_grep.Position

---@class ast_grep.MetaVar
---@field text string
---@field range ast_grep.Range

---@class ast_grep.MetaVariables
---@field single table<string, ast_grep.MetaVar>
---@field multi table<string, ast_grep.MetaVar[]>
---@field transformed table<string, string>

---@class ast_grep.Match
---@field text string
---@field range ast_grep.Range
---@field file string # relative path to the file
---@field lines string # surrounding lines of the match
---@field replacement string? # optional replacement if present
---@field replacementOffsets ast_grep.ByteOffset?
---@field metaVariables ast_grep.MetaVariables?

local M = {}
local TEXT_WIDTH = 40

---@param out vim.SystemCompleted
local function handleError(out)
    if out.code ~= 0 or out.signal ~= 0 then
        log.fatalf("ast-grep failed:\n%s", out.stderr)
    end
end

---comment
---@param text string
---@param len integer
---@return string
local function trimText(text, len)
    assert(len > 3)
    if #text <= len then return text end
    return text:sub(1, len - 3) .. "..."
end

---@param single table<string, ast_grep.MetaVar>
---@param multi table<string, ast_grep.MetaVar[]>
---@return { name: string, var: ast_grep.MetaVar}[]
local function combineMetavars(single, multi)
    ---@type ast_grep.MetaVar[]
    local out = {}
    for name, var in pairs(single) do
        var.text = ("(%s): %s"):format(name, var.text)
        table.insert(out, var)
    end
    for name, vars in pairs(multi) do
        for _, var in ipairs(vars) do
            var.text = ("(%s): %s"):format(name, var.text)
            table.insert(out, var)
        end
    end
    table.sort(out, function(a, b)
        if a.range.start.line < b.range.start.line then return true end
        if a.range.start.line > b.range.start.line then return false end
        return a.range.start.column < b.range.start.column
    end)
    return out
end

---comment
---@param entry vim.quickfix.entry
---@param data ast_grep.Match|ast_grep.MetaVar
---@return vim.quickfix.entry
local function populateEntry(entry, data)
    for key, value in pairs({
        lnum = data.range.start.line + 1,
        col = data.range.start.column + 1,
        end_lnum = data.range["end"].line + 1,
        end_col = data.range["end"].column + 1,
        text = trimText(data.text, TEXT_WIDTH),
    }) do
        entry[key] = value
    end
    return entry
end

---@param out vim.SystemCompleted
---@param cb (fun(matches:ast_grep.Match[]):boolean)?
local function populateQflist(out, cb)
    handleError(out)
    ---@type ast_grep.Match[]
    local matches = vim.fn.json_decode(out.stdout)
    local add_to_list = true
    if cb then add_to_list = cb(matches) end
    if not add_to_list then return end
    ---@type vim.quickfix.entry[]
    local qflist = {}
    for _, match in ipairs(matches) do
        local entry = { filename = match.file, vcol = false, type = "", }
        if match.metaVariables then
            local combined_metavars = combineMetavars(match.metaVariables.single, match.metaVariables.multi)
            for _, var in ipairs(combined_metavars) do
                table.insert(qflist, populateEntry(vim.deepcopy(entry), var))
            end
        else
            table.insert(qflist, populateEntry(entry, match))
        end
    end
    if #qflist == 0 then
        log.warn("ast-grep did not find anything!")
        return
    end
    vim.fn.setqflist(qflist)
end

---comment
---@param rule string|table<string, any>
---@return string
local function makeInlineRule(rule)
    if type(rule) == "string" then
        return makeInlineRule({ pattern = rule })
    end
    return vim.fn.json_encode({ id = "inline-rule", language = "lua", rule = rule })
end


---Run ast grep in a given buffer
---@param rule string|table<string,any>
---@param buf BufSpec?
---@param cb (fun(matches:ast_grep.Match[]):boolean)?
function M.ast_grep(rule, buf, cb)
    if not buf then buf = { vim.fn.bufname('%') } end
    ---@type string[]
    buf = vim.iter(buf):map(function(b)
        if type(b) == "number" then
            return vim.fn.bufname(b)
        end
        return b
    end):totable()
    local args = { "ast-grep", "scan", "--json=compact" }
    args = vim.list_extend(args, buf)

    args = vim.list_extend(args, { "--inline-rules", makeInlineRule(rule) })

    vim.system(args, { text = true }, vim.schedule_wrap(function(out) populateQflist(out, cb) end))
end

return M
