require "utils".ftplugin(
    require "config.common".text:with({ ["@treesitter"] = { "highlight" } }),
    function() require "utils.lsp".enableLspTools() end
)
