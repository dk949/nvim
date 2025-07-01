local lazy = require("lazy")
local M = {}
local lsp = vim.lsp

local enabled_lsps = {}

---ensure an LSP server is installed with mason
---@param name string|false
local function ensureInstalled(name)
    if not name then return end
    local reg = require("mason-registry")
    if reg.is_installed(name) then return end
    local pkg = reg.get_package(name)
    pkg:install()
end


---Load all required plugins and ensure the LSP is installed
---@param name {config:string, mason:(string|boolean)?}
local function setupLSP(name)
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
    ensureInstalled(name.mason)
    vim.lsp.config("*", {
        capabilities = require('cmp_nvim_lsp').default_capabilities()
    })
end


---@param name {config:string, mason:(string|boolean)?}|string
function M.enableLsp(name)
    -- XXX: will result in infinite recursion without this due to `doautocmd FileType`
    if type(name) == "string" then name = { config = name, mason = name } end
    if enabled_lsps[name.config] then return end
    enabled_lsps[name.config] = true
    if name.mason == nil then name.mason = name.config end
    vim.lsp.enable(name.config)
    setupLSP(name)
end

function M.toggleInlay()
    return function()
        lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled())
    end
end

function M.getEnabledLSPs()
    return vim.tbl_keys(enabled_lsps)
end

---comment
---@param bufnr integer?
---@return boolean
function M.bufHasLSP(bufnr)
    if not bufnr then bufnr = vim.fn.bufnr() end
    return not vim.tbl_isempty(vim.lsp.get_clients { bufnr = bufnr })
end

return M
