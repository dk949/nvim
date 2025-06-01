vim.g.mapleader      = " "
vim.g.maplocalleader = " "

vim.opt.showmode     = false
vim.opt.splitbelow   = true
vim.opt.splitright   = true
vim.opt.foldenable   = false
vim.opt.spelllang    = 'en_gb'
vim.opt_local.spell  = true
vim.opt.diffopt:append("vertical")

require("config.options.line_numbers")
require("config.options.tabs")
require("config.options.search")
require("config.options.mouse")
require("config.options.diag")
require("config.options.complete")
require("config.options.yank")
require("config.keymap").global:defaultApply()
require("config.keymap").lsp:defaultApplyOn("LspAttach")
