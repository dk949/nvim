local api = vim.api
-- Map the leader key to space
vim.g.mapleader = dk949.leader

vim.cmd [[filetype plugin on]]
vim.cmd [[filetype plugin indent on]]

vim.cmd [[set relativenumber number]]

vim.cmd [[set wildignorecase]]

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
vim.cmd([[set tabstop=]] .. dk949.tabstop)
vim.cmd([[set shiftwidth=]] .. dk949.tabstop)
vim.cmd([[set softtabstop=]] .. dk949.tabstop)
vim.cmd [[set expandtab]]

-- rememebr file
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = [[mkview]],
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    command = [[silent! loadview]],
})


-- When searching with only lowercase letters, case will be ignored. Not ignored with capitals.
vim.cmd [[set ignorecase]]
vim.cmd [[set smartcase]]


-- Incremental search
vim.cmd [[set incsearch]]


-- Search is not highlighted
vim.cmd [[set nohlsearch]]


-- Search through subdirectories recursively
vim.cmd [[set path+=**]]

-- Spilts act as expected
vim.cmd [[set splitbelow]]
vim.cmd [[set splitright]]

-- Mouse
vim.cmd([[set mouse=]] .. dk949.mouse)
