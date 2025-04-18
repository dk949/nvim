local api = vim.api
local utils = require("utils")
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
    callback = function()
        if vim.opt_local.number:get() then
            vim.opt_local.relativenumber = true
            vim.opt_local.number = true
        end
    end,
    group = line_number_grp
})

vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    callback = function()
        if vim.opt_local.number:get() then
            vim.opt_local.relativenumber = false
        end
    end,
    group = line_number_grp
})

-- setting tabsize
vim.opt.tabstop = dk949.tabstop
vim.opt.shiftwidth = dk949.tabstop
vim.opt.softtabstop = dk949.tabstop
vim.opt.expandtab = true

require "remember-where" {}.installHandler()


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
