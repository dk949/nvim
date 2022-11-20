require("misc.utils")
local api = vim.api

-- Turning on the filetype plugin
vim.cmd[[filetype plugin on]]
vim.cmd[[filetype plugin indent on]]

-- Hybrid numbering in normal mode and normal numbering in insert mode
local relNum = setter {relativenumber = true, number = true}
local noRelNum = setter {relativenumber = false, number = true}
augroup("NumberGroup", {
    InsertLeave = {callback = relNum},
    InsertEnter = {callback = setter {relativenumber = false}},
})
relNum()

--  Terminal stuff
augroup("TerminalGroup", {
    TermOpen = {callback = setter {relativenumber = false, number = false}},
    [{"BufWinEnter","WinEnter"}] = {pattern = "term://*", command = "startinsert"}
})

-- Remove unnecessary auto formatting
augroup("FormatOptsGroup", {
    BufEnter = { callback = function() vim.opt.formatoptions:remove({'c','r','o', 't'}) end}
})

-- No whitespace at the ned of lines
augroup("NoTrailingSpacesGroup", {
    BufWritePre = {command = [[%s/\s\+$//e]]},
})

augroup("RememberFileGroup", {
    VimLeave = {command = [[mkview]]},
    VimEnter = {command = [[silent! loadview]]}
})

-- setting tabsize
vim.opt.tabstop = dk949.tabstop
vim.opt.shiftwidth = dk949.tabstop
vim.opt.softtabstop = dk949.tabstop
vim.opt.expandtab = true

-- When searching with only lowercase letters, case will be ignored. Not ignored with capitals.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Incremental search and no highlighting
vim.opt.incsearch = true
vim.opt.hlsearch = false

-- Search through subdirectories recursively
vim.opt.path:append("**")

-- Spilts act as expected
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Mouse
vim.opt.mouse = dk949.mouse
