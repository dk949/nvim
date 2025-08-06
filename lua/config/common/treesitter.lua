local M = {}



---@param conf (true|("indent"|"incremental_selection"|"highlight")[])
function M.setup(conf)
    if conf == true then conf = { "highlight", "indent", "incremental_selection" } end
    ---@type string
    local enable_list = vim.iter(conf):map(function(c) return ":TSBufEnable " .. c end):join(" | ")

    -- Scheduling this to avoid waiting for TS to load
    vim.schedule(function()
        vim.cmd(enable_list)
        vim.b.treesitter_disable_list = vim.iter(conf):map(function(c) return ":TSBufDisable " .. c end):join(" | ")
    end)
    return [[call v:lua.require("config.common.treesitter").undo()]]
end

function M.undo()
    if vim.b.treesitter_disable_list then
        vim.cmd(vim.b.treesitter_disable_list)
    end
end

return M
