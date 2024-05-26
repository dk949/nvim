local api = vim.api
local utils = require("utils")
local termutils = require("termutils")
-- Map the leader key to space
vim.g.mapleader = dk949.leader

vim.cmd [[filetype plugin on]]
vim.cmd [[filetype plugin indent on]]

vim.opt.showmode       = false
vim.opt.number         = true
vim.opt.relativenumber = true

-- Hybrid numbering in normal mode and normal numbering in insert mode
local line_number_grp  = vim.api.nvim_create_augroup("line_numbers", { clear = true })
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    command = "set relativenumber number",
    group = line_number_grp
})

vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    command = "set norelativenumber",
    group = line_number_grp
})

-- setting tabsize
vim.opt.tabstop = dk949.tabstop
vim.opt.shiftwidth = dk949.tabstop
vim.opt.softtabstop = dk949.tabstop
vim.opt.expandtab = true

-- rememebr file
vim.api.nvim_create_autocmd({ "BufLeave", "BufWinLeave", "InsertLeave" }, {
    pattern = "*",
    callback = function()
        if vim.fn.bufname() ~= "" then
            vim.cmd [[mkview]]
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufEnter" }, {
    pattern = "*",
    callback = function()
        if not vim.g.file_line_fired then
            vim.cmd [[silent! loadview]]
        end
    end
})


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

vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        if vim.fn.argc(-1) == 0 then
            require('telescope.builtin').oldfiles()
        end
    end
})

vim.opt.wildignorecase = true
vim.opt.ignorecase = true
vim.opt.smartcase = true


-- Incremental search
vim.opt.incsearch = true


-- Search is not highlighted
vim.opt.hlsearch = false


-- Search through subdirectories recursively
vim.opt.path:append("**")

-- Spilts act as expected
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Mouse
vim.opt.mouse = dk949.mouse
