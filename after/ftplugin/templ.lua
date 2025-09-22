local enableLspTools = require "utils.lsp".enableLspTools
require "utils".ftplugin(
    require "config.common".prog:with({ ["@treesitter"] = { "highlight" } }),
    function()
        enableLspTools "templ"
        enableLspTools { config = "tailwindcss", mason = "tailwindcss-language-server" }
        -- enableLspTools({ config = "htmx", mason = "htmx-lsp" }, {version = "0.1.0"})
    end
)
