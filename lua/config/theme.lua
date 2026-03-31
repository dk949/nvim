local keymap = require("config.keymap")
local utils = require("utils")

local current = "dark"
local colorschemes = { dark = "habamax", light = "shine" }
local function invert(col) if col == "dark" then return "light" else return "dark" end end

local tweakTable = {
    light = function()
        local dfact = 0x170f07
        local normal = vim.api.nvim_get_hl(0, { name = "Normal", create = false, link = false })
        -- local pmenu = vim.api.nvim_get_hl(0, { name = "Pmenu", create = false, link = false })
        local linenr = vim.api.nvim_get_hl(0, { name = "LineNr", create = false, link = false })
        local comment = vim.api.nvim_get_hl(0, { name = "Comment", create = false, link = false })
        normal.bg = normal.bg - dfact
        -- pmenu.bg = pmenu.bg - dfact
        linenr.fg = linenr.fg - dfact
        -- need to make sure comment fg is not the same as pmenu bg, or hidden files become invisible in popups
        comment.fg = comment.fg - (dfact * 4)
        vim.api.nvim_set_hl(0, "Normal", normal)
        -- vim.api.nvim_set_hl(0, "Pmenu", pmenu)
        vim.api.nvim_set_hl(0, "LineNr", linenr)
        vim.api.nvim_set_hl(0, "Comment", comment)
    end,
    dark = function()
        local lfact = 0x0c141c
        local normal = vim.api.nvim_get_hl(0, { name = "Normal", create = false, link = false })
        local pmenu = vim.api.nvim_get_hl(0, { name = "Pmenu", create = false, link = false })
        local linenr = vim.api.nvim_get_hl(0, { name = "LineNr", create = false, link = false })
        normal.bg = normal.bg + lfact
        pmenu.bg = pmenu.bg + lfact
        linenr.fg = linenr.fg + lfact
        vim.api.nvim_set_hl(0, "Normal", normal)
        vim.api.nvim_set_hl(0, "Pmenu", pmenu)
        vim.api.nvim_set_hl(0, "LineNr", linenr)
    end
}

---@return vim.api.keyset.get_hl_info[]
local function getAllHeadings()
    ---@type vim.api.keyset.get_hl_info[]
    local out = {}
    for level = 1, 6 do
        table.insert(out,
            vim.api.nvim_get_hl(0, { name = "@markup.heading." .. tostring(level), create = false, link = false }))
    end
    return out
end

---@param headings vim.api.keyset.get_hl_info[]
local function setAllHeadings(headings)
    for level, heading in ipairs(headings) do
        vim.api.nvim_set_hl(0, "@markup.heading." .. tostring(level), heading)
    end
end

local function tweaks()
    tweakTable[current]()
    local comment = vim.api.nvim_get_hl(0, { name = "Comment", create = false, link = false })
    local normal_float = vim.api.nvim_get_hl(0, { name = "NormalFloat", create = false, link = false })
    local constant = vim.api.nvim_get_hl(0, { name = "Constant", create = false, link = false })
    local character = vim.api.nvim_get_hl(0, { name = "Character", create = false, link = false })
    local type = vim.api.nvim_get_hl(0, { name = "Type", create = false, link = false })
    local statement = vim.api.nvim_get_hl(0, { name = "Statement", create = false, link = false })
    local macro = vim.api.nvim_get_hl(0, { name = "Macro", create = false, link = false })
    local function_ = vim.api.nvim_get_hl(0, { name = "Function", create = false, link = false })
    local headings = getAllHeadings()
    vim.api.nvim_set_hl(0, "FloatBorder", normal_float)
    normal_float.bold = true
    vim.api.nvim_set_hl(0, "FloatTitle", normal_float)
    vim.api.nvim_set_hl(0, "ColorColumn", { bg = function_.fg })
    vim.api.nvim_set_hl(0, "NonText", comment)
    headings[1].fg = constant.fg
    headings[2].fg = character.fg
    headings[3].fg = type.fg
    headings[4].fg = statement.fg
    headings[5].fg = macro.fg
    headings[6].fg = function_.fg
    setAllHeadings(headings)
end

local M = {}


function M.toggle()
    current = invert(current)
    vim.cmd.colorscheme(colorschemes[current])
end

function M.setup()
    utils.withAugroup("color", function(grp)
        return vim.api.nvim_create_autocmd("ColorScheme", {
            callback = tweaks,
            group = grp,
        })
    end)

    vim.cmd.colorscheme(colorschemes[current])

    keymap.color:defaultApply { colortoggle = M.toggle }

    vim.opt.fillchars:append({ eob = " " })
    vim.opt.guicursor =
    "n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor,t:block-blinkon500-blinkoff500-TermCursor"
end

return M
