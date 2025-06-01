local utils = require("utils")

utils.withAugroup("hlyank", function(grp)
    vim.api.nvim_create_autocmd("TextYankPost", {
        callback = function()
            vim.hl.on_yank { timeout = 1000 }
        end,
        group = grp,
    })
end)
