local utils = require("utils")
local M = {}
local lsp = vim.lsp


---@param name {config:string, mason:(string|boolean)?}
function M.enableLsp(name)
    if type(name) == "string" then name = { config = name, mason = name } end
    if name.mason == nil then name.mason = name.config end
    vim.lsp.enable(name.config)
    if name.mason then
        utils.withAugroup("lsp_enable", function(grp)
                vim.api.nvim_create_autocmd("VimEnter", {
                    callback = function()
                        local reg = require("mason-registry")
                        if reg.is_installed(name.mason) then return end
                        local pkg = reg.get_package(name.mason)
                        pkg:install()
                    end,
                    group = grp
                })
            end,
            { clear = false })
    end
end

function M.toggleInlay()
    lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled())
end


return M
