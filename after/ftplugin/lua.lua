local utils = require "utils"
local lsp_utils = require "utils.lsp"
utils.ftplugin(function()
    vim.opt_local.signcolumn = "yes"
    lsp_utils.enableLsp({
        config = "lua_ls",
        mason = "lua-language-server",
    })
end)
