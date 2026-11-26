local keymap = require("config.keymap")
local api = vim.api

local current
local function invert(col) if col == "dark" then return "light" else return "dark" end end

---@param name string
---@return vim.api.keyset.get_hl_info
local function hl(name) return api.nvim_get_hl(0, { name = name, link = false }) end

---WCAG contrast ratio between two RGB colours
---@param a integer
---@param b integer
---@return number
local function contrast(a, b)
    local function lum(c)
        local function ch(v)
            v = v / 255
            return v <= 0.03928 and v / 12.92 or ((v + 0.055) / 1.055) ^ 2.4
        end
        return 0.2126 * ch(bit.rshift(c, 16)) + 0.7152 * ch(bit.band(bit.rshift(c, 8), 0xff))
            + 0.0722 * ch(bit.band(c, 0xff))
    end
    local x, y = lum(a), lum(b)
    if x < y then x, y = y, x end
    return (x + 0.05) / (y + 0.05)
end

---Linear blend: `t` = 1 is `a`, `t` = 0 is `b`
---@param a integer
---@param b integer
---@param t number
---@return integer
local function mix(a, b, t)
    local r = 0
    for _, sh in ipairs { 16, 8, 0 } do
        local ca, cb = bit.band(bit.rshift(a, sh), 0xff), bit.band(bit.rshift(b, sh), 0xff)
        r = r + bit.lshift(math.floor(ca * t + cb * (1 - t) + 0.5), sh)
    end
    return r
end

-- Minimum contrast against the statusline background we aim for (WCAG AA for normal text)
local MIN_CONTRAST = 4.5
-- Regular statusline text should stand out a bit more than the dim bits (WCAG AAA)
local TEXT_CONTRAST = 7

---Statusline/tabline highlight groups (used by config.statusline), derived from the current colorscheme
local function statuslineHighlights()
    local base = hl("StatusLine")
    local bg = base.bg or hl("Normal").bg or 0
    local fg = base.fg or hl("Normal").fg or 0xffffff

    -- Push colours towards black on light backgrounds, towards white on dark ones
    local away = contrast(bg, 0) > contrast(bg, 0xffffff) and 0 or 0xffffff

    ---`c` itself if readable on the statusline, otherwise `c` darkened/lightened just enough to be
    ---@param c integer
    ---@param min number? minimum contrast, default MIN_CONTRAST
    ---@return integer
    local function readable(c, min)
        min = min or MIN_CONTRAST
        for t = 1, 0, -0.05 do
            local m = mix(c, away, t)
            if contrast(m, bg) >= min then return m end
        end
        return away
    end

    ---First candidate group whose foreground is readable as-is; if none is, the first one made readable
    ---(keeps the hue, e.g. magenta stays magenta in light themes)
    ---@param from string[]
    ---@return integer
    local function pick(from)
        local first
        for _, g in ipairs(from) do
            local c = hl(g).fg
            if c then
                if contrast(c, bg) >= MIN_CONTRAST then return c end
                first = first or c
            end
        end
        return readable(first or fg)
    end

    ---@param name string
    ---@param color integer
    ---@param extra vim.api.keyset.highlight?
    local function def(name, color, extra)
        api.nvim_set_hl(0, name, vim.tbl_extend("force", { fg = color, bg = bg }, extra or {}))
    end

    -- Some themes (e.g. tokyonight-day) have barely readable statusline text; darken/lighten it if needed.
    -- This also overrides StatusLine itself, since unstyled parts (flags, separators, extras) use it.
    fg = readable(fg, TEXT_CONTRAST)
    if fg ~= base.fg then
        api.nvim_set_hl(0, "StatusLine", vim.tbl_extend("force", base, { fg = fg }))
    end

    -- Faded statusline text: as far towards the background as it goes while staying readable.
    local dim = fg
    for t = 0.5, 1, 0.05 do
        local c = mix(fg, bg, t)
        if contrast(c, bg) >= MIN_CONTRAST then
            dim = c
            break
        end
    end

    local red = pick { "DiagnosticError", "@variable.builtin", "ErrorMsg" }
    local green = pick { "String", "GitSignsAdd", "DiagnosticOk" }
    local blue = pick { "Function", "GitSignsChange" }
    local orange = pick { "Constant", "DiagnosticWarn" }
    local purple = pick { "@keyword", "Statement" }
    local yellow = pick { "DiagnosticWarn", "Constant" }
    local teal = pick { "DiagnosticHint", "Special" }

    def("StlFile", fg, { bold = true })
    def("StlDim", dim)
    def("StlBranch", purple)

    def("StlModeN", blue, { bold = true })
    def("StlModeI", green, { bold = true })
    def("StlModeV", yellow, { bold = true })
    def("StlModeS", yellow, { bold = true })
    def("StlModeR", red, { bold = true })
    def("StlModeC", orange, { bold = true })
    def("StlModeT", teal, { bold = true })

    def("StlAdded", green)
    def("StlChanged", blue)
    def("StlRemoved", red)
    def("StlConflict", red, { bold = true })

    def("StlError", red)
    def("StlWarn", yellow)
    def("StlInfo", pick { "DiagnosticInfo" })
    def("StlHint", teal)

    -- TabLineFill same as statusline bg
    api.nvim_set_hl(0, "TabLineFill", { bg = bg })

    -- Inactive windows' statuslines and inactive tab numbers
    for _, g in ipairs { "StatusLineNC", "TabLine" } do
        local h = hl(g)
        api.nvim_set_hl(0, g, vim.tbl_extend("force", h, { fg = dim }))
    end
    -- Current tab: statusline background on the accent blue
    api.nvim_set_hl(0, "TabLineSel", { fg = bg, bg = blue, bold = true })
end

local M = {}

function M.toggle()
    current = invert(current)
    vim.o.background = current
end

M.style = "storm"

function M.setup()
    keymap.color:defaultApply { colortoggle = M.toggle }
    current = vim.o.background

    vim.cmd.colorscheme("tokyonight")
    statuslineHighlights()
    -- Colorschemes reset highlight groups (tokyonight also reloads on `background` changes)
    require("utils").withAugroup("theme_statusline", function(grp)
        return api.nvim_create_autocmd("ColorScheme", { group = grp, callback = statuslineHighlights })
    end)
    vim.opt.guicursor =
    "n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor,t:block-blinkon500-blinkoff500-TermCursor"
end

return M
