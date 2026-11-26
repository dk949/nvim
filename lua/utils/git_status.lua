--- Async, cached repository-wide git status for the statusline.
---
--- The statusline only ever reads the cache (`M.get`). `git status` runs in the background on events
--- that can plausibly change the repo state, debounced and with at most one job per repository.

local M = {}

---@class GitRepoStatus
---@field head string? branch name, nil when detached
---@field oid string? short commit hash
---@field tag string? tag pointing at HEAD (only looked up when detached)
---@field ahead integer
---@field behind integer
---@field added integer
---@field modified integer
---@field deleted integer
---@field renamed integer
---@field unmerged integer
---@field untracked integer
---@field stashed integer

---`false` = the last `git status` failed. Kept distinct from "never queried" (nil) so a repo where git keeps
---failing isn't retried on every statusline redraw; the usual refresh events still retry it.
---@type table<string, GitRepoStatus|false>
local cache = {}
---@type table<string, boolean> repo is currently being queried
local running = {}
---@type table<string, boolean> another refresh was requested while one was running
local pending = {}

local DEBOUNCE_MS = 300
local timer = assert(vim.uv.new_timer())
---@type table<string, true>
local queued = {}

---@param out string
---@return GitRepoStatus
local function parse(out)
    local st = {
        ahead = 0, behind = 0, added = 0, modified = 0, deleted = 0,
        renamed = 0, unmerged = 0, untracked = 0, stashed = 0,
    }
    for line in vim.gsplit(out, "\n", { plain = true, trimempty = true }) do
        local kind = line:sub(1, 1)
        if kind == "#" then
            local key, val = line:match("^# (%S+) (.*)$")
            if key == "branch.head" then
                if val ~= "(detached)" then st.head = val end
            elseif key == "branch.oid" then
                if val ~= "(initial)" then st.oid = val:sub(1, 7) end
            elseif key == "branch.ab" then
                local a, b = val:match("^%+(%d+) %-(%d+)")
                st.ahead, st.behind = tonumber(a) or 0, tonumber(b) or 0
            elseif key == "stash" then
                st.stashed = tonumber(val) or 0
            end
        elseif kind == "1" or kind == "2" then
            local xy = line:sub(3, 4)
            if kind == "2" then st.renamed = st.renamed + 1 end
            if xy:find("A", 1, true) then st.added = st.added + 1 end
            if xy:find("D", 1, true) then st.deleted = st.deleted + 1 end
            if xy:find("[MT]") then st.modified = st.modified + 1 end
        elseif kind == "u" then
            st.unmerged = st.unmerged + 1
        elseif kind == "?" then
            st.untracked = st.untracked + 1
        end
    end
    return st
end

---@param root string
local function run(root)
    if running[root] then
        pending[root] = true
        return
    end
    running[root] = true
    local git = { "git", "--no-optional-locks", "-C", root }
    ---@param st GitRepoStatus|false
    local function done(st)
        vim.schedule(function()
            running[root] = nil
            cache[root] = st
            vim.cmd.redrawstatus { bang = true }
            if pending[root] then
                pending[root] = nil
                run(root)
            end
        end)
    end
    vim.system(
        vim.list_extend(vim.deepcopy(git), { "status", "--porcelain=v2", "--branch", "--show-stash" }),
        { text = true },
        function(res)
            if res.code ~= 0 then return done(false) end
            local st = parse(res.stdout or "")
            if st.head or not st.oid then return done(st) end
            -- Detached HEAD: see if it's sitting on a tag
            vim.system(vim.list_extend(vim.deepcopy(git), { "tag", "--points-at", "HEAD" }), { text = true },
                function(tres)
                    if tres.code == 0 then st.tag = vim.split(tres.stdout or "", "\n", { trimempty = true })[1] end
                    done(st)
                end)
        end
    )
end

local function flush()
    local roots = queued
    queued = {}
    for root in pairs(roots) do run(root) end
end

---Schedule a (debounced) refresh of the repository `root`
---@param root string?
function M.refresh(root)
    if not root or root == "" then return end
    queued[root] = true
    timer:stop()
    timer:start(DEBOUNCE_MS, 0, vim.schedule_wrap(flush))
end

---@param buf integer?
---@return string?
local function bufRoot(buf)
    local dict = vim.b[buf or 0].gitsigns_status_dict
    return dict and dict.root or nil
end

---Refresh every repository we know about (e.g. after focus returns from another program)
local function refreshAll()
    for root in pairs(cache) do M.refresh(root) end
    M.refresh(bufRoot())
end

---Cached status of the repo `buf` belongs to (nil if unknown or not in a repo)
---@param buf integer
---@return GitRepoStatus?
function M.get(buf)
    local root = bufRoot(buf)
    if not root then return nil end
    local st = cache[root]
    if st == nil and not running[root] and not queued[root] then M.refresh(root) end
    return st or nil
end

function M.setup()
    require("utils").withAugroup("git_repo_status", function(grp)
        local on_gitsigns = vim.api.nvim_create_autocmd("User", {
            group = grp,
            pattern = "GitSignsUpdate",
            callback = function(ev)
                local buf = ev.data and ev.data.buffer
                M.refresh(bufRoot(buf))
            end,
        })
        local on_buf = vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
            group = grp,
            callback = function(ev) M.refresh(bufRoot(ev.buf)) end,
        })
        local on_extetn_change = vim.api.nvim_create_autocmd({ "FocusGained", "ShellCmdPost", "TermLeave", "DirChanged" }, {
            group = grp,
            callback = refreshAll,
        })
        local on_fugitive = vim.api.nvim_create_autocmd("User", {
            group = grp,
            pattern = "FugitiveChanged",
            callback = refreshAll,
        })
        return on_gitsigns, on_buf, on_extetn_change, on_fugitive
    end)
end

return M
