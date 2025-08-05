local M = {}


function M.setup()
    require "ibl".setup_buffer(vim.fn.bufnr(), { enabled = true })
    return [[call v:lua.require("config.common.indent_blankline").undo()]]
end

function M.undo()
    require "ibl".setup_buffer(vim.fn.bufnr(), { enabled = false })
end

return M
