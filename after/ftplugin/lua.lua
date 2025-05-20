require "utils".ftplugin(
    {
        signcolumn = "yes",
        formatoptions = require "config.format".prog,
        colorcolumn = "+1",
        textwidth = 110,
    },
    function()
        require "utils.lsp".enableLsp({
            config = "lua_ls",
            mason = "lua-language-server",
        })
    end
)
