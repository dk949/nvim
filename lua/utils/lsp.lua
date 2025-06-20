local utils = require("utils")
local lazy = require("lazy")
local M = {}
local lsp = vim.lsp


---ensure an LSP server is installed with mason
---@param name string|boolean
local function ensureInstalled(name)
    if not name then return end
    local reg = require("mason-registry")
    if reg.is_installed(name) then return end
    local pkg = reg.get_package(name)
    pkg:install()
end


---Load all required plugins and ensure the LSP is installed
---@param name string|boolean
local function setupLSP(name)
    return function()
        lazy.load({
            plugins = {
                "nvim-lspconfig",
                "mason.nvim",
                "LuaSnip",
                "nvim-cmp",
                "cmp_luasnip",
                "cmp-nvim-lsp",
            }
        })
        vim.cmd [[doautocmd FileType]]
        ensureInstalled(name)
        vim.lsp.config("*", {
            capabilities = require('cmp_nvim_lsp').default_capabilities()
        })
    end
end


---@param name {config:string, mason:(string|boolean)?}
function M.enableLsp(name)
    if type(name) == "string" then name = { config = name, mason = name } end
    if name.mason == nil then name.mason = name.config end
    vim.lsp.enable(name.config)
    utils.withAugroup("lsp_enable",
        -- TODO(dk949): This will break for multiple files with different LSPs
        function(grp) vim.api.nvim_create_autocmd("VimEnter", { callback = setupLSP(name.mason), group = grp }) end,
        { clear = false })
end

function M.toggleInlay()
    return function()
        lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled())
    end
end

return M
