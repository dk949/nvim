local lazy = require("lazy")
local pkg = require("utils.pkg")
local M = {}
local lsp = vim.lsp

local enabled_lsps = {}
local enabled_snippets = {}

---@alias Override vim.lsp.Config|fun(_:vim.lsp.Config?):vim.lsp.Config
---@alias SnippetFn fun():nil
---@alias LspSpec {config:string, mason:MasonSpec?}

---@class Config
---@field override Override?
---@field snippets SnippetFn?

---Load all required plugins and ensure the LSP is installed
---@param spec LspSpec
---@param override Override?
local function setupLSP(spec, override)
    if override then
        if type(override) == "table" then
            vim.lsp.config(spec.config, override)
        else
            vim.lsp.config[spec.config] = override(vim.lsp.config[spec.config])
        end
    end
    vim.lsp.config(spec.config, {
        capabilities = require('cmp_nvim_lsp').default_capabilities()
    })
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
    pkg.ensureInstalled(spec.mason)
end


---@param name LspSpec|string
---@param conf Config?
function M.enableLsp(name, conf)
    -- XXX: will result in infinite recursion without this due to `doautocmd FileType`
    if type(name) == "string" then name = { config = name, mason = name } end
    if not conf then conf = {} end
    if not enabled_lsps[name.config] then
        enabled_lsps[name.config] = true
        if name.mason == nil then name.mason = name.config end
        vim.lsp.enable(name.config)
        setupLSP(name, conf.override)
    end
    if conf.snippets then
        local id = M.getFtpluginId(conf.snippets)
        if not enabled_snippets[id] then
            conf.snippets()
            enabled_snippets[id] = true
        end
    end
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

---@param func function
---@return string
function M.getFtpluginId(func)
    local info = debug.getinfo(func, "S")
    if not info or not info.source then error("Could not get function source") end

    local source = info.source
    if source:sub(1, 1) ~= "@" then error("Expected function to be defined in a file!") end

    local path = source:sub(2)
    local name = path:match("([^/\\]+)$")
    return name:match("^(.*)%.%w+$") or name
end

return M
