require "utils".ftplugin(
    require "config.common".prog,
    function()
        require "utils.lsp".enableLsp {
            config = "lua_ls",
            mason = "lua-language-server",
        }
    end
)
