require("utils")
local fn = vim.fn
local api = vim.api

local Pos = 1
local Neg = -1
local function chWidth(dir, inc)
    api.nvim_win_set_width(0, api.nvim_win_get_width(0) + (inc * dir))
end
local function chHeight(dir, inc)
    api.nvim_win_set_height(0, api.nvim_win_get_height(0) + (inc * dir))
end

local function changeWindowSize(letter)
    assert(letter ~= nil, "letter cannot be nil")
    assert(type(letter) == "string" and #letter == 1, "expected letter to be a character")
    if fn.winnr('$') <= 1 then return end

    local pos = api.nvim_win_get_position(0)

    local winChange = switch(letter){
        h = function() return (pos[2] == 0) and {chWidth,  Neg} or {chWidth,  Pos} end,
        j = function() return (pos[1] == 0) and {chHeight, Pos} or {chHeight, Neg} end,
        k = function() return (pos[1] == 0) and {chHeight, Neg} or {chHeight, Pos} end,
        l = function() return (pos[2] == 0) and {chWidth,  Pos} or {chWidth,  Neg} end,
    }
    winChange[1](winChange[2], dk949.winSzInc)
end

return {
    changeWindowSize = changeWindowSize,
    Neg = Neg,
    Pos = Pos,
    chWidth = chWidth,
    chHeight = chHeight,
}
