local M = {}
local feat = require("config.common.feat")

-- TODO(dk949): consider moving the entire ftplugin mechanism here
---comment
---@param settings table
---@return table
---@return string
function M.setAll(settings)
    local undo_list = {}
    for k, v in pairs(feat) do
        if settings[k] ~= nil then
            local undo = v(settings[k])
            if undo then table.insert(undo_list, undo) end
            settings[k] = nil
        end
    end
    return settings, vim.iter(undo_list):join(' | ')
end

return M
