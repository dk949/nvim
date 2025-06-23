local M = {}


local function formatLogItem(item)
    if type(item) == "string" then
        return item
    else
        return vim.inspect(item)
    end
end


local function formatLog(...)
    local args = { ... }
    if #args == 1 then
        if type(args[1]) == "table" then
            return vim.iter(args[1])
                :map(function(item)
                    if type(item) == "table" then
                        return vim.iter(item):map(formatLogItem):join('')
                    else
                        return formatLogItem(item)
                    end
                end)
                :join('\n')
        else
            return formatLogItem(args[1])
        end
    else
        return vim.iter(args):map(formatLogItem):join("")
    end
end

---

---Print arguments with `vim.notify` with `DEBUG` level
---
---See `log.info` for how arguments are formatted
---@param ... unknown
function M.debug(...) vim.notify(formatLog(...), vim.log.levels.DEBUG) end

---Print arguments with `vim.notify` with `INFO` level
---
---The arguments are formatted in the following way:
---* When an argument is printed, it is done with `vim.inspect`, except strings,
---  which are printed with no quotes.
---  NOTE: Strings nested in tables *will* have quotes.
---* If multiple arguments are passed, they are joined with *no* separators.
---* A single non table argument is printed as is
---* A single table argument is printed with each non-table element of the table
---  printed on separate lines.
---* Each table element is joined together with no separators
---
---Examples:
---```lua
---    log.info("hello", "world")         --> helloworld
---    log.info({"hello"}, "world")       --> { "hello" }world
---    log.info({"hello", "world"})       --> hello
---                                       --- world
---    log.info({{"he", "llo"}, "world"}) --> hello
---                                       --- world
---    log.info({"hello", {{"world"}}})   --> hello
---                                       --- { "world" }
---```
---@param ... unknown
function M.info(...) vim.notify(formatLog(...), vim.log.levels.INFO) end

---Print arguments with `vim.notify` with `WARN` level
---
---See `log.info` for how arguments are formatted
---@param ... unknown
function M.warn(...) vim.notify(formatLog(...), vim.log.levels.WARN) end

---Print arguments with `vim.notify` with `ERROR` level
---
---See `log.info` for how arguments are formatted
---@param ... unknown
function M.error(...) vim.notify(formatLog(...), vim.log.levels.ERROR) end

---Calls `error`. Correctly sets level of the error
---
---See `log.info` for how arguments are formatted
---@param ... unknown
function M.fatal(...) error(formatLog(...), 2) end

---

---Like log.debug, but arguments are formatted with `string.format`
---@param fmt string
---@param ... unknown
function M.debugf(fmt, ...) vim.notify(string.format(fmt, ...), vim.log.levels.DEBUG) end

---Like log.info, but arguments are formatted with `string.format`
---@param fmt string
---@param ... unknown
function M.infof(fmt, ...) vim.notify(string.format(fmt, ...), vim.log.levels.INFO) end

---Like log.warn, but arguments are formatted with `string.format`
---@param fmt string
---@param ... unknown
function M.warnf(fmt, ...) vim.notify(string.format(fmt, ...), vim.log.levels.WARN) end

---Like log.error, but arguments are formatted with `string.format`
---@param fmt string
---@param ... unknown
function M.errorf(fmt, ...) vim.notify(string.format(fmt, ...), vim.log.levels.ERROR) end

---Like log.fatal, but arguments are formatted with `string.format`
---@param fmt string
---@param ... unknown
function M.fatalf(fmt, ...) error(string.format(fmt, ...), 2) end

local sched = {}

for name, fn in pairs(M) do
    sched[name] = vim.schedule_wrap(fn)
end

M.sched = sched

return M
