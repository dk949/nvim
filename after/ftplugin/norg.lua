require "utils".ftplugin(
    require "config.common".text:with({
        conceallevel = 3,
        formatoptions = vim.NIL,
        ["@treesitter"] = true,
        ["@logicalLines"] = false,
    }),
    function()
        require("config.keymap").neorg:defaultApply()
    end
)
