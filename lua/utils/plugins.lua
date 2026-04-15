---@module "lazy"
local M = {}


---@param spec LazyPluginSpec
---@return LazySpec
function M.dirPlug(spec)
    local dir = assert(spec.dir)
    return vim.tbl_extend("error", vim.deepcopy(spec), {
        cond = vim.uv.fs_stat(vim.fs.abspath(dir)) ~= nil,
    })
end

return M
