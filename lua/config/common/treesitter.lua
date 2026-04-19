local M = {}
local log = require("utils.log")

-- TODO(dk949): Rewrite in terms of vim.treesitter.start/vim.treesitter.stop


---@type ({highlight:string?,fold:{foldexpr:string,foldmethod:string}?,indent:string?})[]
local ts_data = {}

---@alias TsHighlightConf boolean|{lang:string}
---@alias TsModuleConf {[number]:"indent"|"fold"|"highlight", indent:boolean?,fold:boolean?,highlight:TsHighlightConf?}
---@alias TsConf TsModuleConf|{[1]:TsModuleConf,install:string}|true
---@alias TsConfNorm {modules:{indent:boolean?,fold:boolean?,highlight:TsHighlightConf?},install:string?}


---@param conf TsConf
---@return TsConfNorm
local function normaliseConf(conf)
    if conf == true then return { modules = { highlight = true, indent = true, fold = true } } end
    ---@type TsModuleConf
    local mod_conf
    ---@type string?
    local install
    if conf.install then
        install = conf.install
        mod_conf = conf[1] --[[@as TsModuleConf]]
    else
        mod_conf = conf --[[@as TsModuleConf]]
    end
    ---@type TsConfNorm
    local out = { modules = {}, install = install }
    for key, value in pairs(mod_conf) do
        if type(key) == "number" then
            assert(value == "indent" or value == "fold" or value == "highlight")
            out.modules[value] = true
        else
            assert(key == "indent" or key == "fold" or key == "highlight")
            assert(type(value) == "boolean" or (key == "highlight" and type(value) == "table" and value.lang))
            out.modules[key] = value
        end
    end
    return out
end

---@param conf TsConf
function M.setup(conf)
    local norm_conf = normaliseConf(conf)
    local mod_conf = norm_conf.modules
    local buf = vim.api.nvim_get_current_buf()
    local win = vim.api.nvim_get_current_win()

    local ts = require("nvim-treesitter")
    ts.install(norm_conf.install or vim.bo.filetype)
        :await(function(err)
            if err then
                ts_data[buf] = nil
                log.warn("Failed to start treesitter: ", err)
                return
            end
            if not vim.api.nvim_buf_is_valid(buf) then return end
            ts_data[buf] = {}
            for c, v in pairs(mod_conf) do
                if c == "indent" and v then
                    ts_data[buf].indent = vim.bo[buf].indentexpr
                    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                elseif c == "fold" and v then
                    if vim.api.nvim_win_is_valid(win) then
                        -- TODO(dk949): This likely breaks if buffer is reopened in another window
                        ts_data[buf].fold = {
                            foldexpr = vim.wo[win].foldexpr,
                            foldmethod = vim.wo[win].foldmethod
                        }
                        vim.wo[win].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                        vim.wo[win].foldmethod = 'expr'
                    end
                elseif c == "highlight" and v then
                    ts_data[buf].highlight = vim.bo[buf].syntax
                    local lang
                    if type(v) == "table" then lang = v.lang end
                    vim.treesitter.start(buf, lang)
                    vim.bo[buf].syntax = "NO"
                else
                    log.warn("Unknown config '", c, "'")
                end
            end
        end)
    return [[call v:lua.require("config.common.treesitter").undo()]]
end

function M.undo()
    local buf = vim.api.nvim_get_current_buf()

    if not ts_data[buf] then return end
    if ts_data[buf].highlight then
        vim.treesitter.stop(buf)
        vim.bo.syntax = ts_data[buf].highlight
    end
    if ts_data[buf].fold then
        vim.wo.foldmethod = ts_data[buf].fold.foldmethod
        vim.wo.foldexpr = ts_data[buf].fold.foldexpr
    end
    if ts_data[buf].indent then
        vim.bo.indentexpr = ts_data[buf].indent
    end
end

return M
