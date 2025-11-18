local ui = require("utils.ui")

---@class GuestData
---@field filetype string?
---@field buftype string?

---@class GuestDataContainer
---@field data GuestData

---@class PostOpenData: GuestDataContainer
---@field winnr integer -- The window that the file was opened in
---@field bufnr integer -- The buffer number of the file that was opened
---@field filetype string -- The filetype of the file that was opened
---@field is_blocking  boolean -- Whether the guest will be blocked while the host edits
---@field is_diff boolean --  Whether the files were opened in diff mode

---@class OpenData: GuestDataContainer
---@field files {bufnr: integer, fname: string }[] -- The list of files passed to the host.
---@field argv string[] -- The full argv list from the guest instance.
---@field stdin_buf any? -- Info about the stdin buffer, if one was created.
---@field guest_cwd string -- The current working directory of the guest instance.
---@field data any -- The data passed to the host from the guest_data hook.

---comment
---@param ctx OpenData
local function openFloat(ctx)
    local buf = ctx.files[1].bufnr
    local win = ui.openFloat(true, nil, { border = "rounded" }, buf)
    return buf, win
end

return {
    window = { open = "alternate" },
    hooks = {
        -- relies on https://github.com/willothy/flatten.nvim/pull/113
        ---@param data GuestDataContainer
        ---@return table?
        pre_open = function(data)
            if data.data.filetype == "gitcommit" or data.data.filetype == "gitrebase" then
                return { window = { open = openFloat } }
            end
        end,
        ---@return GuestData
        guest_data = function()
            return { filetype = vim.bo.filetype, buftype = vim.bo.buftype }
        end
    },
}
