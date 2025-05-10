-- https://github.com/folke/trouble.nvim
return { {
    "folke/trouble.nvim",
    lazy = true,
    opts = {
        auto_close = false,      -- auto close when there are no items
        auto_open = false,       -- auto open when there are items
        auto_preview = true,     -- automatically open preview when on an item
        auto_refresh = true,     -- auto refresh when open
        auto_jump = false,       -- auto jump to the item when there's only one
        focus = false,           -- Focus the window when opened
        restore = true,          -- restores the last location in the list when opening
        follow = true,           -- Follow the current item
        indent_guides = true,    -- show indent guides
        max_items = 200,         -- limit number of items that can be displayed per section
        multiline = true,        -- render multi-line messages
        pinned = false,          -- When pinned, the opened trouble window will be bound to the current buffer
        warn_no_results = true,  -- show a warning when there are no results
        open_no_results = false, -- open the trouble window when there are no results
        ---@type trouble.Window.opts
        win = { height = 15, posiiton = "botton" },
        -- Key mappings can be set to the name of a builtin action,
        -- or you can define your own custom action.
        ---@type table<string, trouble.Action.spec|false>
        keys = {
            ["?"] = "help",
            r = "refresh",
            R = "toggle_refresh",
            q = "close",
            o = "jump_close",
            ["<esc>"] = "cancel",
            ["<cr>"] = "jump",
            ["<2-leftmouse>"] = "jump",
            ["<c-s>"] = "jump_split",
            ["<c-v>"] = "jump_vsplit",
            -- go down to next item (accepts count)
            j = "next",
            ["}"] = "next",
            ["]]"] = "next",
            -- go up to prev item (accepts count)
            k = "prev",
            ["{"] = "prev",
            ["[["] = "prev",
            dd = "delete",
            d = { action = "delete", mode = "v" },
            i = "inspect",
            p = "preview",
            P = "toggle_preview",
            zo = "fold_open",
            zO = "fold_open_recursive",
            zc = "fold_close",
            zC = "fold_close_recursive",
            za = "fold_toggle",
            zA = "fold_toggle_recursive",
            zm = "fold_more",
            zM = "fold_close_all",
            zr = "fold_reduce",
            zR = "fold_open_all",
            zx = "fold_update",
            zX = "fold_update_all",
            zn = "fold_disable",
            zN = "fold_enable",
            zi = "fold_toggle_enable",
        }
    }
} }
