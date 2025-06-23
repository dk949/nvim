local M = {}
local feat = require("config.common.feat")

-- TODO(dk949): consider moving the entire ftplugin mechanism here
function M.setAll(settings)
    local out = ""
    for k, v in pairs(feat) do
        if settings[k] ~= nil then
            local undo = v(settings[k])
            if undo then out = out .. " | " .. undo end
            settings[k] = nil
        end
    end
    return settings, out
end

return M
