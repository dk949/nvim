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

function M.debug(...) vim.notify(formatLog(...), vim.log.levels.DEBUG) end

function M.info(...) vim.notify(formatLog(...), vim.log.levels.INFO) end

function M.warn(...) vim.notify(formatLog(...), vim.log.levels.WARN) end

function M.error(...) vim.notify(formatLog(...), vim.log.levels.ERROR) end

function M.fatal(...) error(formatLog(...), 2) end

---

function M.debugf(fmt, ...) vim.notify(string.format(fmt, ...), vim.log.levels.DEBUG) end

function M.infof(fmt, ...) vim.notify(string.format(fmt, ...), vim.log.levels.INFO) end

function M.warnf(fmt, ...) vim.notify(string.format(fmt, ...), vim.log.levels.WARN) end

function M.errorf(fmt, ...) vim.notify(string.format(fmt, ...), vim.log.levels.ERROR) end

function M.fatalf(fmt, ...) error(string.format(fmt, ...), 2) end

return M
