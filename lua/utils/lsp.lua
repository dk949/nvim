local utils = require("utils")
local lazy = require("lazy")
local M = {}
local lsp = vim.lsp


---@param name {config:string, mason:(string|boolean)?}
function M.enableLsp(name)
    if type(name) == "string" then name = { config = name, mason = name } end
    if name.mason == nil then name.mason = name.config end
    vim.lsp.enable(name.config)
    utils.withAugroup("lsp_enable", function(grp)
            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function()
                    lazy.load({ plugins = {"nvim-lspconfig", "mason.nvim", "LuaSnip"} })
                    vim.cmd [[doautocmd FileType]]
                    if name.mason then
                        local reg = require("mason-registry")
                        if reg.is_installed(name.mason) then return end
                        local pkg = reg.get_package(name.mason)
                        pkg:install()
                    end
                end,
                group = grp
            })
        end,
        { clear = false })
end

function M.toggleInlay()
    lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled())
end

return M
