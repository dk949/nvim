require "utils".ftplugin(
    vim.tbl_deep_extend("error", require "config.common".prog, {
        formatexpr = [[v:lua.require("config.common.formatting").pythonExpr()]],
    }),
    function()
        require "utils.lsp".enableLsp "basedpyright"
    end
)
