vim.opt.number         = true
vim.opt.relativenumber = true

require "utils".withAugroup("line_numbers", function(grp)
    vim.api.nvim_create_autocmd("InsertLeave", {
        pattern = "*",
        callback = function(args)
            if vim.startswith(args.match, "oil://") then return end
            if vim.opt_local.number then
                vim.opt_local.relativenumber = true
                vim.opt_local.number = true
            end
        end,
        group = grp,
    })

    vim.api.nvim_create_autocmd("InsertEnter", {
        pattern = "*",
        callback = function(args)
            if vim.startswith(args.match, "oil://") then return end
            if vim.opt_local.number then
                vim.opt_local.relativenumber = false
            end
        end,
        group = grp,
    })
end)
