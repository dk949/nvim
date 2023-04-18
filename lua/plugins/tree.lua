-- https://github.com/nvim-tree/nvim-tree.lua
return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        -----------------------------------------------------
        local function on_attach(bufnr)
            local api = require('nvim-tree.api')

            local function opts(desc)
                return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            api.config.mappings.default_on_attach(bufnr)

            vim.keymap.set('n', 'o', api.node.run.system, opts('Run System'))
            vim.keymap.set('n', '<space>mi', api.node.show_info_popup, opts('Info'))
            vim.keymap.set('n', '/', api.live_filter.start, opts('Filter'))
            vim.keymap.set('n', '<space>/', api.live_filter.clear, opts('Clean Filter'))
        end

        -----------------------------------------------------
        require("nvim-tree").setup {
            -- changed
            on_attach = on_attach,
            sort_by = "case_sensitive",
            hijack_unnamed_buffer_when_opening = true,
            hijack_cursor = true,
            hijack_netrw = true,
            modified = { enable = true },
            remove_keymaps = { "s", "<C-k>", "f", "F" },
            view = {
                centralize_selection = true,
                width = 35
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
