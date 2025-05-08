-- https://github.com/dk949/file_line.nvim
return { {
    "dk949/file_line.nvim",
    lazy = false,
    config = function() require "file_line".register() end
} }
