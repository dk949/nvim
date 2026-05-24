require "utils".ftplugin(
    require "config.common".prog:with {
        formatprg = require("config.common.formatting").rustPrg,
        spell = false,
    },
    function()
        require "utils.lsp".enableLspTools({ config = "rust_analyzer", mason = "rust-analyzer" })
    end
)
