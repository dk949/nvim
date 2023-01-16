-- https://github.com/nvim-tree/nvim-tree.lua
return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        require("nvim-tree").setup {
            -- changed
            sort_by = "case_sensitive",
            hijack_unnamed_buffer_when_opening = true,
            hijack_cursor = true,
            hijack_netrw = true,
            modified = { enable = true },
            remove_keymaps = { "s", "<C-k>", "f", "F" },
            view = {
                centralize_selection = true,
                width = 35,
                mappings = {
                    list = {
                        { key = "o", action = "system_open" },
                        { key = "<space>mi", action = "toggle_file_info" },
                        { key = "/", action = "live_filter" },
                        { key = "<space>/", action = "clear_live_filter" },
                    },
                },
            },
            renderer = {
                highlight_git = true,
                group_empty = true,
                highlight_opened_files = "icon",
                indent_markers = { enable = true },
                special_files = {
                    "Makefile", "README.md",
                    "readme.md", "LICENSE", "CMakeLists.txt",
                    "vcpkg.json", "package,json", "dub.json",
                    "dub.sdl", "build.zig", "Cargo.toml",
                }
            },
            actions = {
                use_system_clipboard = false,
                open_file = { quit_on_open = true },
            },
            tab = { sync = { open = true, close = true } },
        }
    end
}
