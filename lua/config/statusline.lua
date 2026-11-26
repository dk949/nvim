local api = vim.api
local git_status = require("utils.git_status")

local M = {}

-- Components

---@param s string
---@return string
local function esc(s) return (s:gsub("%%", "%%%%")) end

local MODES = {
    n = "N", i = "I", v = "V", V = "V", ["\22"] = "V", s = "S", S = "S", ["\19"] = "S",
    R = "R", c = "C", t = "T", r = "…", ["!"] = "!",
}

-- Highlight group (StlMode<X>) per mode letter; anything not listed uses Normal mode's colour
local MODE_HL = { N = "N", I = "I", V = "V", S = "S", R = "R", C = "C", T = "T" }

local function mode()
    local m = api.nvim_get_mode().mode:sub(1, 1)
    local letter = MODES[m] or m
    return ("%%#StlMode%s#%s "):format(MODE_HL[letter] or "N", letter)
end

local ICONS = {
    branch = "",
    added = " ",
    ahead = "⇡ ",
    behind = "⇣ ",
    commit = "󰜘",
    deleted = " ",
    diverged = "⇕ ",
    modified = " ",
    renamed = " ",
    stashed = "$",
    tag = "󰓹 ",
    unmerged = " ",
    untracked = "?",
}

---@param parts string[]
---@param n integer?
---@param group string
---@param icon string
local function count(parts, n, group, icon)
    if n and n > 0 then parts[#parts + 1] = ("%%#%s#%s%d"):format(group, icon, n) end
end

---Branch (or commit/tag when detached) and repo-wide state
---@param buf integer
local function git(buf)
    local st = git_status.get(buf)
    local head = vim.b[buf].gitsigns_head
    if not st and (not head or head == "") then return "" end

    local parts = {}
    if st and not st.head then
        if st.tag then parts[#parts + 1] = "%#StlBranch#" .. ICONS.tag .. " " .. esc(st.tag) end
        if st.oid then parts[#parts + 1] = "%#StlBranch#" .. ICONS.commit .. " " .. st.oid end
    else
        parts[#parts + 1] = "%#StlBranch#" .. ICONS.branch .. " " .. esc(st and st.head or head)
    end
    if st then
        if st.ahead > 0 and st.behind > 0 then
            parts[#parts + 1] = ("%%#StlDim#%s%s%d%s%d"):format(ICONS.diverged, ICONS.ahead, st.ahead, ICONS.behind,
                st.behind)
        else
            count(parts, st.ahead, "StlDim", ICONS.ahead)
            count(parts, st.behind, "StlDim", ICONS.behind)
        end
        count(parts, st.unmerged, "StlConflict", ICONS.unmerged)
        count(parts, st.added, "StlAdded", ICONS.added)
        count(parts, st.modified, "StlChanged", ICONS.modified)
        count(parts, st.renamed, "StlChanged", ICONS.renamed)
        count(parts, st.deleted, "StlRemoved", ICONS.deleted)
        count(parts, st.untracked, "StlDim", ICONS.untracked)
        count(parts, st.stashed, "StlDim", ICONS.stashed)
    end
    return " " .. table.concat(parts, " ") .. "%*  "
end

---Per-file line counts, GitHub style (+added -removed).
---gitsigns counts a modified line once as `changed`; GitHub counts it as one removal plus one addition.
---@param buf integer
local function fileDiff(buf)
    local d = vim.b[buf].gitsigns_status_dict
    if not d then return "" end
    local changed = d.changed or 0
    local parts = {}
    count(parts, (d.added or 0) + changed, "StlAdded", "+")
    count(parts, (d.removed or 0) + changed, "StlRemoved", "-")
    if #parts == 0 then return "" end
    return table.concat(parts, " ") .. "%*  "
end

local SEVERITIES = {
    { vim.diagnostic.severity.ERROR, "StlError", "E" },
    { vim.diagnostic.severity.WARN,  "StlWarn",  "W" },
    { vim.diagnostic.severity.INFO,  "StlInfo",  "I" },
    { vim.diagnostic.severity.HINT,  "StlHint",  "H" },
}

---@param buf integer
local function diagnostics(buf)
    if not package.loaded["vim.diagnostic"] then return "" end
    local counts = vim.diagnostic.count(buf)
    if not next(counts) then return "" end
    local signs = (vim.diagnostic.config() or {}).signs
    local text = type(signs) == "table" and signs.text or {}
    local parts = {}
    for _, s in ipairs(SEVERITIES) do
        local n = counts[s[1]]
        if n then
            local sym = vim.trim(text[s[1]] or s[3])
            parts[#parts + 1] = ("%%#%s#%s %d"):format(s[2], esc(sym), n)
        end
    end
    return table.concat(parts, " ") .. "%*  "
end

---Bits from the default statusline that only show up occasionally
---@param buf integer
local function extras(buf)
    local parts = {}
    local bo = vim.bo[buf]
    if bo.buftype == "terminal" and bo.channel ~= 0 then
        local info = api.nvim_get_chan_info(bo.channel)
        if info.exitcode and info.exitcode >= 0 then parts[#parts + 1] = ("[Exit: %d]"):format(info.exitcode) end
    end
    local ok, progress = pcall(vim.ui.progress_status)
    if ok and progress and progress ~= "" then parts[#parts + 1] = progress end
    if vim.o.showcmdloc == "statusline" then parts[#parts + 1] = "%-10.S" end
    local km = vim.b[buf].keymap_name
    if km then parts[#parts + 1] = "<" .. esc(km) .. ">" end
    if (bo.busy or 0) > 0 then parts[#parts + 1] = "◐" end
    if #parts == 0 then return "" end
    return table.concat(parts, " ") .. " "
end

local RULER = "%#StlDim#%-10.(%l:%c%V%) %P "
local ALIGN = "%="
local FILENAME = "%<%#StlFile#%f%* %h%w%-3(%m%)%r"

function M.statusline()
    local win = vim.g.statusline_winid or api.nvim_get_current_win()
    local buf = api.nvim_win_get_buf(win)
    if win ~= api.nvim_get_current_win() then
        return " %<%f %h%w%m%r%=" .. diagnostics(buf) .. "%-10.(%l:%c%V%) %P "
    end
    return table.concat {
        " ",
        mode(),
        FILENAME,
        git(buf),
        ALIGN,
        fileDiff(buf),
        extras(buf),
        diagnostics(buf),
        RULER,
    }
end

-- Tabline: breadcrumbs on the left, tab pages on the right (only when there are several)

local function tabs()
    local n = vim.fn.tabpagenr("$")
    if n < 2 then return "" end
    local cur = vim.fn.tabpagenr()
    local parts = {}
    for i = 1, n do
        parts[#parts + 1] = ("%%#%s#%%%dT %d %%T"):format(i == cur and "TabLineSel" or "TabLine", i, i)
    end
    return table.concat(parts)
end

---@param buf integer?
local function hasCrumbs(buf)
    local navic = package.loaded["nvim-navic"]
    return navic ~= nil and navic.is_available(buf)
end

function M.tabline()
    local crumbs = hasCrumbs() and package.loaded["nvim-navic"].get_location() or ""
    return "%#TabLineFill# " .. crumbs .. "%#TabLineFill#%=" .. tabs()
end

---Show the tabline once the first buffer with breadcrumbs appears, then keep it for the rest of the session.
---Before that it's only shown when there are several tabs.
---@return boolean shown
local function updateShowTabline()
    if not hasCrumbs() then return false end
    vim.o.showtabline = 2
    return true
end

-------------------------------------------------------------------------------

function M.setup()
    git_status.setup()

    vim.o.statusline = "%!v:lua.require'config.statusline'.statusline()"
    vim.o.tabline = "%!v:lua.require'config.statusline'.tabline()"
    vim.o.showtabline = 1

    require("utils").withAugroup("statusline", function(grp)
        local modech = vim.api.nvim_create_autocmd("ModeChanged", {
            group = grp,
            callback = function() vim.schedule(vim.cmd.redrawstatus) end
        })
        -- The tabline is not redrawn on cursor movement by itself. navic updates its context in its own
        -- CursorMoved handler, so redraw after it (scheduled) to pick up the new location.
        local redraw = vim.api.nvim_create_autocmd({ "CursorMoved", "CursorHold", "BufEnter", "LspAttach", "LspDetach", "InsertLeave" }, {
            group = grp,
            callback = function() vim.schedule(vim.cmd.redrawtabline) end,
        })
        -- Scheduled so navic's own LspAttach (which sets up the buffer) has already run.
        -- Deletes itself once the tabline is shown, since it's never hidden again.
        local update
        update = vim.api.nvim_create_autocmd("LspAttach", {
            group = grp,
            callback = function()
                vim.schedule(function()
                    if updateShowTabline() then pcall(api.nvim_del_autocmd, update) end
                end)
            end,
        })

        -- navic only stores new symbols when the LSP replies; it doesn't recompute the cursor context until
        -- the next cursor move, so crumbs look stale/empty after opening a file or editing. Fix that up here.
        local lsp = vim.api.nvim_create_autocmd("LspRequest", {
            group = grp,
            callback = function(ev)
                local req = ev.data.request
                if req.type ~= "complete" or req.method ~= "textDocument/documentSymbol" then return end
                vim.schedule(function()
                    if ev.buf ~= api.nvim_get_current_buf() or not package.loaded["nvim-navic"] then return end
                    require("nvim-navic.lib").update_context(ev.buf)
                    vim.cmd.redrawtabline()
                end)
            end,
        })
        return modech, redraw, update, lsp
    end)
end

return M
