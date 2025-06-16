local M = {}
local feat = require("config.common.feat")

-- TODO(dk949): consider moving the entire ftplugin mechanism here
function M.setAll(settings)
    local out = ""
    for k, v in pairs(feat) do
        if settings[k] ~= nil then
            out = out .. " " .. v(settings[k])
            settings[k] = nil
        end
    end
    return settings, out
end






return M
