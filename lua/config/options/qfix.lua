local utils = require "utils"
local keymap = require "config.keymap".quickfix
local function setupQuickfix()
    utils.withAugroup("qfix", function(grp)
        return vim.api.nvim_create_autocmd("BufWinEnter", {
            group = grp,
            callback = function(args)
                if vim.fn.win_gettype(vim.fn.bufwinid(args.buf)) ~= 'quickfix' then return end
                vim.api.nvim_create_autocmd("BufWipeout", {
                    callback = setupQuickfix,
                    buffer = args.buf,
                    once = true,
                    group = grp
                })
                keymap:defaultApply(nil, args.buf)
                return true
            end,
        })
    end)
end

setupQuickfix()
