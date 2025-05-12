vim.g.mapleader      = " "
vim.g.maplocalleader = " "

vim.opt.showmode     = false
vim.opt.splitbelow   = true
vim.opt.splitright   = true
vim.opt.foldenable   = false

require("config.options.line_numbers")
require("config.options.tabs")
require("config.options.terminal")
require("config.options.search")
require("config.options.mouse")
require("config.options.diag")
require("config.options.complete")
require("config.keymap").global_mappings:defaultApply()
require("config.keymap").lsp_mappings:defaultApplyOn("LspAttach")
