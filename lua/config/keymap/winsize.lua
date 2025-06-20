local switch = require("utils").switch

return function(winSzInc)
    local winsize = {}
    local Pos = 1
    local Neg = -1
    local function chWidth(dir, inc)
        vim.api.nvim_win_set_width(0, vim.api.nvim_win_get_width(0) + (inc * dir))
    end

    local function chHeight(dir, inc)
        vim.api.nvim_win_set_height(0, vim.api.nvim_win_get_height(0) + (inc * dir))
    end

    function winsize.changeWindowSize(letter)
        assert(type(letter) == "string" and #letter == 1, "expected letter to be a character")
        return function()
            if vim.fn.winnr('$') <= 1 then return end

            local pos = vim.api.nvim_win_get_position(0)

            local winChange = switch(letter) {
                h = function() return (pos[2] == 0) and { chWidth, Neg } or { chWidth, Pos } end,
                j = function() return (pos[1] == 0) and { chHeight, Pos } or { chHeight, Neg } end,
                k = function() return (pos[1] == 0) and { chHeight, Neg } or { chHeight, Pos } end,
                l = function() return (pos[2] == 0) and { chWidth, Pos } or { chWidth, Neg } end,
            }
            winChange[1](winChange[2], winSzInc)
        end
    end

    return winsize
end
