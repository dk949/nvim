local enableLspTools = require "utils.lsp".enableLspTools
require "utils".ftplugin(
    require "config.common".prog:with({
        ["@treesitter"] = { "highlight" },
        formatexpr = require("config.common.formatting").lspExpr,
    }),
    function()
        enableLspTools { config = "ts_ls", mason = "typescript-language-server" }
    end
)
