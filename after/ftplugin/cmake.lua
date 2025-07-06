require "utils".ftplugin(
    vim.tbl_deep_extend("error", require "config.common".prog, {
        formatprg = require("config.common.formatting").cmakePrg,
    }),
    function()
        require "utils.lsp".enableLsp {
            config = "cmake",
            mason = {
                "cmake-language-server",
                "cmakelang",
            },
        }
    end
)
