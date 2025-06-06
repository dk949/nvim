return {
    window = {
        open = "alternate"
    },
    hooks = {
        -- relies on https://github.com/willothy/flatten.nvim/pull/113
        pre_open = function(data)
            if data.data.current then return { window = { open = "current" } } end
        end,
        guest_data = function()
            return { current = vim.bo.filetype == "gitcommit" or vim.bo.filetype == "gitrebase" }
        end
    },
}
