-- https://github.com/folke/trouble.nvim
return {
    "folke/trouble.nvim",
    config = function()
        require("trouble").setup {
            auto_open = false, -- automatically open the list when you have diagnostics

            height = 15, -- height of the trouble list when position is top or bottom
            position = "bottom", -- position of the list can be: bottom, top, left, right
            width = 50, -- width of the list when position is left or right
            icons = true, -- use devicons for filenames
            mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
            action_keys = { -- key mappings for actions in the trouble list
                hover = "<leader>mi", -- opens a small popup with the full multiline message
                toggle_mode = "<space>", -- toggle between "workspace" and "document" diagnostics mode

                close = "q", -- close the list
                cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
                refresh = "r", -- manually refresh
                jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
                open_split = { "<c-x>" }, -- open buffer in new split
                open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
                open_tab = { "<c-t>" }, -- open buffer in new tab
                jump_close = { "o" }, -- jump to the diagnostic and close the list
                toggle_preview = "P", -- toggle auto_preview
                preview = "p", -- preview the diagnostic location
                close_folds = { "zM", "zm" }, -- close all folds
                open_folds = { "zR", "zr" }, -- open all folds
                toggle_fold = { "zA", "za" }, -- toggle fold of current file
                previous = "k", -- previous item
                next = "j" -- next item
            },
            auto_close = false, -- automatically close the list when you have no diagnostics
            auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
            auto_fold = false, -- automatically fold a file trouble list at creation
            auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
            use_diagnostic_signs = true -- enabling this will use the signs defined in your lsp client
        }
    end
}
