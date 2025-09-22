local log = require("utils.log")
local M = {}

---@alias MasonSpec string|string[]|false

---ensure an LSP server is installed with mason
---@param name MasonSpec
---@param version string?
function M.ensureInstalled(name, version)
    if not name then return end
    local name_list
    if type(name) == "string" then name_list = { name } else name_list = name end
    local reg = require("mason-registry")
    reg.refresh(function()
        for _, n in ipairs(name_list) do
            if not reg.is_installed(n) then
                log.sched.warnf("Package %s is not installed", n)
                local pkg = reg.get_package(n)
                log.sched.infof("Installing %s", n)
                pkg:install(version and { version = version }, function(success, receipt)
                    if success then
                        log.sched.infof("Successfully installed %s", n)
                    end
                end)
            end
        end
    end)
end

return M
