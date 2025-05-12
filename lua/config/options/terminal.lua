local utils = require("utils")
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
    pattern = "term://*",
    callback = function()
        if vim.b.term_mode == nil then vim.b.term_mode = "t" end

        utils.switch(vim.b.term_mode) {
            n = function() end,
            t = function() vim.cmd [[:startinsert]] end,
            __default = function(m) error("Unexpected mode: ", m) end,
        }
    end,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "TermUtilsLeave",
    callback = function()
        vim.b.term_mode = 'n'
    end,
})

vim.api.nvim_create_autocmd("TermEnter", {
    pattern = "*",
    callback = function()
        vim.b.term_mode = 't'
    end,
})

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        vim.cmd [[:startinsert]]
    end,
})
