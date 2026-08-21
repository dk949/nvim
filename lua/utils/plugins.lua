local M = {}

---@module "lazy"

---@alias PluginReq {exe:string}

---@param spec LazyPluginSpec
---@return LazySpec
function M.dirPlug(spec)
    local dir = assert(spec.dir)
    return vim.tbl_extend("error", vim.deepcopy(spec), {
        cond = vim.uv.fs_stat(vim.fs.abspath(dir)) ~= nil,
    })
end

---@param spec table
---@return LazySpec
function M.optPlug(spec)
    ---@type PluginReq
    local req = assert(spec.req)
    spec.req = nil
    return vim.tbl_extend("error", vim.deepcopy(spec), {
        cond = vim.fn.executable(req.exe) == 1
    })
end

return M
