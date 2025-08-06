require "utils".ftplugin(
    require "config.common".prog:with({ ["@treesitter"] = { "highlight" } }),
    function()
        require "utils.lsp".enableLspTools "clangd"
    end
)
