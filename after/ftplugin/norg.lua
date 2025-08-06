require "utils".ftplugin(
    require "config.common".text:with({ formatoptions = vim.NIL, ["@treesitter"] = true }),
    function() require("config.keymap").neorg:defaultApply() end
)
