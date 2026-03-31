local M = {}

local ns_id = vim.api.nvim_create_namespace("notes_comment")

---@type (((fun())?)[]?)[]
local active_clears = {} -- map: bufnr -> { clear_fn, clear_fn, ... }

---@class NotesComment.Opts
---@field hl_group string
local default_opts = {
    hl_group = "Comment",
}

local _q = nil
local function get_ts_query()
    if _q then return _q end

    local ok, q = pcall(vim.treesitter.query.parse, "markdown", "(paragraph) @para")
    if ok and q then
        _q = q

        return q
    end

    return nil
end

---@param bufnr integer
local function clear_active_highlights(bufnr)
    local clears = active_clears[bufnr]

    if not clears then
        return
    end
    for _, clear_fn in ipairs(clears) do
        if clear_fn then
            pcall(clear_fn)
        end
    end

    active_clears[bufnr] = nil
    pcall(vim.api.nvim_buf_clear_namespace, bufnr, ns_id, 0, -1)
end

---@param bufnr integer
---@param opts NotesComment.Opts
local function highlight_buffer(bufnr, opts)
    clear_active_highlights(bufnr)


    local ts_query = get_ts_query()

    if not ts_query then return end

    local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "markdown")
    if not ok or not parser then return end

    local trees = parser:parse()
    if not trees or #trees == 0 then return end
    local root = trees[1]:root()

    local line_count = vim.api.nvim_buf_line_count(bufnr)
    local buf_clears = {}

    for id, node, _ in ts_query:iter_captures(root, bufnr, 0, -1) do
        local name = ts_query.captures[id] -- "para" for our query
        if name == "para" then
            local srow, _scol, _erow, _ecol = node:range()

            local first_line = vim.api.nvim_buf_get_lines(bufnr, srow, srow + 1, false)[1]
            if not first_line then goto continue end

            local open = first_line:match("^(:::+)[ \t]*notes[ \t]*$")
            if not open then goto continue end

            local closing_pat = "^" .. string.rep(":", #open) .. "[ \t]*$"
            for j = srow + 1, line_count - 1 do
                local line = vim.api.nvim_buf_get_lines(bufnr, j, j + 1, false)[1]
                if not line then break end
                if line:match(closing_pat) then
                    local start_pos = { srow, 0 }
                    local finish_pos = { j + 1, 0 }
                    local range_opts = {
                        regtype = "V",
                        inclusive = true,
                    }

                    local ok2, _, clear_fn = pcall(vim.hl.range,
                        bufnr,
                        ns_id,
                        opts.hl_group,
                        start_pos,
                        finish_pos,
                        range_opts
                    )
                    if ok2 and clear_fn and type(clear_fn) == "function" then
                        table.insert(buf_clears, clear_fn)
                    end
                    break
                end
            end
        end
        ::continue::
    end

    if #buf_clears > 0 then
        active_clears[bufnr] = buf_clears
    end
end

---@param buf integer
---@param user_opts NotesComment.Opts?
---@return string
function M.setup(buf, user_opts)
    local opts = vim.tbl_deep_extend("force", default_opts, user_opts or {})

    local group_name = "NotesCommentHighlight_" .. tostring(buf)
    local group = vim.api.nvim_create_augroup(group_name, { clear = true })
    vim.b.notes_comment_highlight_buf = buf

    vim.api.nvim_create_autocmd(
        { "BufReadPost", "BufWritePost", "TextChanged", "TextChangedI", "InsertLeave", "BufEnter" },
        {
            group = group,
            buffer = buf,
            callback = function(args)
                pcall(highlight_buffer, args.buf, opts)
            end,
        })

    vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
        group = group,
        buffer = buf,
        callback = function(args)
            clear_active_highlights(args.buf)
        end,
    })

    return [[call v:lua.require("config.common.notes_comment").undo()]]
end

---@param buf integer
function M.clear(buf)
    clear_active_highlights(buf or vim.api.nvim_get_current_buf())
end

function M.undo()
    if not vim.b.notes_comment_highlight_buf then return end
    M.clear(vim.b.notes_comment_highlight_buf)
    vim.b.notes_comment_highlight_buf = nil
end

return M
