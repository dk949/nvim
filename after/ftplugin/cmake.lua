require "utils".ftplugin(
    require "config.common".prog:with {
        formatprg = require("config.common.formatting").cmakePrg,
    },
    function()
        require "utils.lsp".enableLspTools {
            config = "cmake",
            mason = {
                "cmake-language-server",
                "cmakelang",
            },
        }
    end
)
