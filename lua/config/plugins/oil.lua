---@module "oil"
local keymap = require("config.keymap")
local maps = keymap.oil:transform(function(_, m)
    local mode
    if m.mode == "" then mode = nil else mode = m.mode end
    if mode or m.opts then
        return m.lhs, { m.rhs, mode = mode, opts = m.opts }
    else
        return m.lhs, m.rhs
    end
end)


vim.api.nvim_create_autocmd("User", {
    pattern = "OilActionsPost",
    ---comment
    ---@param args {data: {actions: oil.Action[], err: string?}}
    callback = function(args)
        if args.data.err then return end
        for _, action in ipairs(args.data.actions) do
            if action.type ~= "create"
                or action.entry_type ~= "file"
                or not vim.startswith(action.url, "oil:///") then
                goto continue
            end
            ---@type string
            local path = action.url:sub(7)
            local buf = vim.api.nvim_create_buf(false, false)
            vim.api.nvim_buf_set_name(buf, vim.fs.relpath(vim.fn.getcwd(), path) or path)
            vim.api.nvim_buf_call(buf, function()
                vim.cmd [[doautocmd BufNewFile]]
                vim.cmd [[write!]]
            end)
            ::continue::
        end
    end,
})

return {
    win_options = {
        signcolumn = "yes:2",
        number = false,
        relativenumber = false,
    },
    -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
    skip_confirm_for_simple_edits = true,
    keymaps = maps,
    use_default_keymaps = false,
    view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
        is_always_hidden = function(name, _) return name == ".." end,
    },
    float = {
        -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        max_width = 0.5,
        max_height = 0.5,
        border = "rounded",
    },
    confirmation = {
        border = "rounded",
    },
    progress = {
        border = "rounded",
    },
    ssh = {
        border = "rounded",
    },
}
