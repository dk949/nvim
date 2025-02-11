-- https://github.com/stevearc/oil.nvim
return {
    "stevearc/oil.nvim",
    config = function()
        local oil = require("oil")

        oil.setup {
            default_file_explorer = true,
            columns = {
                "icon",
                -- "permissions",
                -- "size",
                -- "mtime",
            },
            -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
            skip_confirm_for_simple_edits = true,
            lsp_file_methods = {
                -- Enable or disable LSP file operations
                enabled = true,
                -- Time to wait for LSP file operations to complete before skipping
                timeout_ms = 1000,
                -- Set to true to autosave buffers that are updated with LSP willRenameFiles
                -- Set to "unmodified" to only save unmodified buffers
                autosave_changes = false,
            },
            -- Set to true to watch the filesystem for changes and reload oil
            watch_for_changes = false,
            -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
            -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
            -- Additionally, if it is a string that matches "actions.<name>",
            -- it will use the mapping at require("oil.actions").<name>
            -- Set to `false` to remove a keymap
            -- See :help oil-actions for a list of all available actions
            keymaps = {
                ["g?"] = { "actions.show_help", mode = "n" },
                ["<CR>"] = "actions.select",
                ["<C-v>"] = { "actions.select", opts = { vertical = true } },
                ["<C-s>"] = { "actions.select", opts = { horizontal = true } },
                ["<C-t>"] = { "actions.select", opts = { tab = true } },
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = { "actions.close", mode = "n" },
                ["<M-l>"] = "actions.refresh",
                ["<BS>"] = { "actions.parent", mode = "n" },
                ["_"] = { "actions.open_cwd", mode = "n" },
                ["~"] = { "actions.cd", mode = "n" },
                ["gs"] = { "actions.change_sort", mode = "n" },
                ["gx"] = "actions.open_external",
                ["g."] = { "actions.toggle_hidden", mode = "n" },
                ["g\\"] = { "actions.toggle_trash", mode = "n" },
                ["gt"] = { "actions.open_terminal" },
            },
            -- Set to false to disable all of the above keymaps
            use_default_keymaps = false,
            view_options = {
                -- Show files and directories that start with "."
                show_hidden = true,
                is_always_hidden = function(name, bufnr)
                    return name == ".."
                end,
                -- Sort file names with numbers in a more intuitive order for humans.
                -- Can be "fast", true, or false. "fast" will turn it off for large directories.
                natural_order = "fast",
                -- Sort file and directory names case insensitive
                case_insensitive = false,
            },
            float = {
                -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                max_width = 0.5,
                max_height = 0.5,
                border = "rounded",
                win_options = { winblend = 0, },
                -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
                get_win_title = nil,
                -- preview_split: Split direction: "auto", "left", "right", "above", "below".
                preview_split = "auto",
                -- This is the config that will be passed to nvim_open_win.
                -- Change values here to customize the layout
                override = function(conf) return conf end,
            },
            -- NOTE: There's some git support, but it's experimental as of 2025-01-25
        }
    end,
}
