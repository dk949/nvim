require "utils".ftplugin(
    require "config.common".prog,
    function()
        require "utils.lsp".enableLsp({ config = "clangd" })
    end
)
