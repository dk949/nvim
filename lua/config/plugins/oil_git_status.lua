-- TODO(dk949): Custom highlights
return function()
    require('oil-git-status').setup {
        symbols = {
            index = {
                ["!"] = " ",
                ["?"] = "?",
                ["A"] = "",
                ["C"] = "󰆏",
                ["D"] = "",
                ["M"] = "",
                ["R"] = "",
                ["T"] = "T",
                ["U"] = "",
                [" "] = " ",
            },
            working_tree = {
                ["!"] = "",
                ["?"] = "?",
                ["A"] = "A",
                ["C"] = "󰆏",
                ["D"] = "",
                ["M"] = "",
                ["R"] = "R",
                ["T"] = "T",
                ["U"] = "",
                [" "] = " ",
            },
        }
    }
    -- local add = vim.api.nvim_get_hl(0, { name = "GitSignsAdd", link = false })
    -- local change = vim.api.nvim_get_hl(0, { name = "GitSignsChange", link = false })
    -- local delete = vim.api.nvim_get_hl(0, { name = "GitSignsDelete", link = false })
    -- local changedelete = vim.api.nvim_get_hl(0, { name = "GitSignsChangedelete", link = false })
    -- local topdelete = vim.api.nvim_get_hl(0, { name = "GitSignsTopdelete", link = false })
    -- local untracked = vim.api.nvim_get_hl(0, { name = "GitSignsUntracked", link = false })
    -- local ignore = vim.api.nvim_get_hl(0, { name = "Comment", link = false })
end
