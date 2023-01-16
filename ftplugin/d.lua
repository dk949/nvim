-- Make
local save_cpo = vim.o.cpo
vim.cmd [[set cpo&vim]]
vim.opt_local.makeprg = "dub"
vim.o.cpo = save_cpo

-- error format
vim.opt_local.errorformat = [[%f(%l\,%c): %t%m]]
