require "utils".ftplugin(
    {
        signcolumn = "yes",
        formatoptions = require "config.format".prog,
    },
    function()
        require "utils.lsp".enableLsp({
            config = "lua_ls",
            mason = "lua-language-server",
        })
    end
)
