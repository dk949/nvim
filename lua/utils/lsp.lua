local lazy = require("lazy")
local pkg = require("utils.pkg")
local M = {}
local lsp = vim.lsp

local enabled_lsps = {}
local enabled_snippets = {}
local NONE_LSP = "@none"

---@alias Override vim.lsp.Config|fun(_:vim.lsp.Config?):vim.lsp.Config
---@alias SnippetFn fun():nil
---@alias LspSpec {config:string, mason:MasonSpec?}

---@class Config
---@field override Override?
---@field snippets SnippetFn?
---@field version string?
---@field force_mason boolean?

---Load all required plugins and ensure the LSP is installed
---@param spec LspSpec
---@param conf Config
local function setupLSP(spec, conf)
    if spec.config ~= NONE_LSP then
        if conf.override then
            if type(conf.override) == "table" then
                vim.lsp.config(spec.config, conf.override)
            else
                vim.lsp.config[spec.config] = conf.override(vim.lsp.config[spec.config])
            end
        end
        vim.lsp.config(spec.config, {
            capabilities = require('cmp_nvim_lsp').default_capabilities()
        })
        lazy.load({ plugins = { "nvim-lspconfig", "mason.nvim" } })
    end
    lazy.load({
        plugins = {
            "LuaSnip",
            "nvim-cmp",
            "cmp_luasnip",
            "cmp-nvim-lsp",
        }
    })
    vim.cmd [[doautocmd FileType]]
    if spec.config ~= NONE_LSP and spec.mason ~= false then
        local name_list
        if type(spec.mason) == "string" then
            name_list = { spec.mason --[[@as string]] }
        else
            name_list = spec.mason --[[@as (string[])]]
        end
        if not conf.force_mason then
            name_list = vim.iter(name_list):filter(function(name)
                return vim.fn.executable(name) == 0
            end):totable() --[[@as (string[])]]
        end
        if #name_list ~= 0 then pkg.ensureInstalled(name_list, conf.version) end
    end
end


---@param lsp_name (LspSpec|string)?
---@param conf Config?
function M.enableLspTools(lsp_name, conf)
    if not lsp_name then lsp_name = NONE_LSP end
    if type(lsp_name) == "string" then lsp_name = { config = lsp_name, mason = lsp_name } end
    if not conf then conf = {} end
    -- XXX: will result in infinite recursion without this due to `doautocmd FileType`
    if not enabled_lsps[lsp_name.config] then
        enabled_lsps[lsp_name.config] = true
        if lsp_name.mason == nil then lsp_name.mason = lsp_name.config end
        if lsp_name ~= NONE_LSP then vim.lsp.enable(lsp_name.config) end
        setupLSP(lsp_name, conf)
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

function M.hover()
    return function()
        lsp.buf.hover({
            border = "rounded",
        })
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
