local utils = require "utils"
local lsp_utils = require "utils.lsp"
utils.ftplugin(function()
    lsp_utils.enableLsp({
        config = "lua_ls",
        mason = "lua-language-server",
    })
end)
