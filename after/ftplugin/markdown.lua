require "utils".ftplugin(
    require "config.common".text:with({
        ["@treesitter"] = { "highlight" },
        ["@notesComment"] = true,
        ["@logicalLines"] = vim.NIL,
    }),
    function() require "utils.lsp".enableLspTools() end
)
