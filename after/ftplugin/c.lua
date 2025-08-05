require "utils".ftplugin(
    require "config.common".prog,
    function()
        require "utils.lsp".enableLspTools "clangd"
    end
)
