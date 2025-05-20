local switch = require("utils").switch

return function(winSzInc)
    local winsize = {}
    winsize.Pos = 1
    winsize.Neg = -1
    function winsize.chWidth(dir, inc)
        vim.api.nvim_win_set_width(0, vim.api.nvim_win_get_width(0) + (inc * dir))
    end

    function winsize.chHeight(dir, inc)
        vim.api.nvim_win_set_height(0, vim.api.nvim_win_get_height(0) + (inc * dir))
    end

    function winsize.changeWindowSize(letter)
        local _ = winsize
        assert(type(letter) == "string" and #letter == 1, "expected letter to be a character")
        if vim.fn.winnr('$') <= 1 then return end

        local pos = vim.api.nvim_win_get_position(0)

        local winChange = switch(letter) {
            h = function() return (pos[2] == 0) and { _.chWidth, _.Neg } or { _.chWidth, _.Pos } end,
            j = function() return (pos[1] == 0) and { _.chHeight, _.Pos } or { _.chHeight, _.Neg } end,
            k = function() return (pos[1] == 0) and { _.chHeight, _.Neg } or { _.chHeight, _.Pos } end,
            l = function() return (pos[2] == 0) and { _.chWidth, _.Pos } or { _.chWidth, _.Neg } end,
        }
        winChange[1](winChange[2], winSzInc)
    end

    return winsize
end
