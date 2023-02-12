local api = vim.api
-- Map the leader key to space
vim.g.mapleader = dk949.leader

vim.cmd [[filetype plugin on]]
vim.cmd [[filetype plugin indent on]]

vim.opt.showmode       = true
vim.opt.number         = true
vim.opt.relativenumber = true

-- Hybrid numbering in normal mode and normal numbering in insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    command = "set relativenumber number",
})

vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    command = "set norelativenumber",
})

-- setting tabsize
vim.opt.tabstop = dk949.tabstop
vim.opt.shiftwidth = dk949.tabstop
vim.opt.softtabstop = dk949.tabstop
vim.opt.expandtab = true

-- rememebr file
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = [[mkview]],
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    command = [[silent! loadview]],
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
