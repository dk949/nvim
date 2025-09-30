local enableLspTools = require "utils.lsp".enableLspTools
require "utils".ftplugin(
    require "config.common".prog:with({
        ["@treesitter"] = { "highlight" },
        formatexpr = require("config.common.formatting").lspExpr,
    }),
    function()
        enableLspTools { config = "html", mason = "html-lsp" }
        enableLspTools { config = "tailwindcss", mason = "tailwindcss-language-server" }
    end
)
