local M = {}

function M.debug(...) vim.notify(vim.iter({ ... }):join('\n'), vim.log.levels.DEBUG) end
function M.info(...) vim.notify(vim.iter({ ... }):join('\n'), vim.log.levels.INFO) end
function M.warn(...) vim.notify(vim.iter({ ... }):join('\n'), vim.log.levels.WARN) end
function M.error(...) vim.notify(vim.iter({ ... }):join('\n'), vim.log.levels.ERROR) end
function M.fatal(...) error(vim.iter({ ... }):join('\n'), 2) end

return M
