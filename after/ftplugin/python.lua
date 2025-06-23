require "utils".ftplugin(
    vim.tbl_deep_extend("error", require "config.common".prog, {
        formatexpr = [[v:lua.require("config.common.formatting").python()]],
    }),
    function()
        require "utils.lsp".enableLsp({
            config = "basedpyright",
            mason = "basedpyright",
        })
    end
)
