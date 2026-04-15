local M = {}
local log = require("utils.log")

-- TODO(dk949): Rewrite in terms of vim.treesitter.start/vim.treesitter.stop


---@type ({highlight:string?,fold:{foldexpr:string,foldmethod:string}?,indent:string?})[]
local ts_data = {}


---@param conf (true|("indent"|"fold"|"highlight")[])
function M.setup(conf)
    if conf == true then conf = { "highlight", "indent", "fold" } end
    local buf = vim.api.nvim_get_current_buf()
    local win = vim.api.nvim_get_current_win()

    local ts = require("nvim-treesitter")
    ts.install(vim.bo.filetype)
        :await(function(err)
            if err then
                ts_data[buf] = nil
                log.warn("Failed to start treesitter: ", err)
                return
            end
            if not vim.api.nvim_buf_is_valid(buf) then return end
            ts_data[buf] = {}
            for _, c in ipairs(conf) do
                if c == "indent" then
                    ts_data[buf].indent = vim.bo[buf].indentexpr
                    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                elseif c == "fold" then
                    -- TODO(dk949): This likely breaks if buffer is reopened in another window
                    ts_data[buf].fold = {
                        foldexpr = vim.wo[win].foldexpr,
                        foldmethod = vim.wo[win].foldmethod
                    }
                    vim.wo[win].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                    vim.wo[win].foldmethod = 'expr'
                elseif c == "highlight" then
                    ts_data[buf].highlight = vim.bo[buf].syntax
                    vim.treesitter.start(buf)
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
