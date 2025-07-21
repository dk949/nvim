require "utils".ftplugin(
    require "config.common".prog:with {
        formatexpr = [[v:lua.require("config.common.formatting").pythonExpr()]],
    },
    function()
        require "utils.lsp".enableLsp "basedpyright"
    end
)
