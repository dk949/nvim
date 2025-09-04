local log = require("utils.log")
local command = vim.api.nvim_create_user_command


--- Run a command (as a table) asynchronously and pipe output into a buffer.
---@param cmd table
---@param bufnr number
---@return number job_id
local function run_cmd_to_buf(cmd, bufnr)
    if type(cmd) ~= "table" then error("cmd must be a table") end
    if not vim.api.nvim_buf_is_valid(bufnr) then error("invalid buffer id: " .. tostring(bufnr)) end

    local ok, _ = pcall(vim.api.nvim_buf_set_lines, bufnr, 0, -1, false, {})
    if not ok then log.fatal("failed to clear buffer ", bufnr) end

    local cur_line = 0
    local function write_lines(_, lines, stream)
        if not lines or #lines == 0 then return end
        local found_end = false
        local real_lines = vim.iter(lines)
            :rev()
            :filter(function(l)
                if found_end then
                    return true
                elseif l ~= nil and l ~= "" then
                    found_end = true
                    return true
                else
                    return false
                end
            end)
            :rev()
            :totable()
        -- -1,-1 appends
        vim.api.nvim_buf_set_lines(bufnr, cur_line, -1, false, real_lines)
        cur_line = cur_line + #real_lines
    end

    local job_id = vim.fn.jobstart(cmd, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = write_lines,
        on_stderr = write_lines,
    })
    if not job_id or job_id <= 0 then log.fatalf("failed to start job (jobstart returned %d)", job_id) end
    return job_id
end


---@param args vim.api.keyset.create_user_command.command_args
local function watch(args)
    local grp = vim.api.nvim_create_augroup("dk949-watch", { clear = true })
    local current_buf = vim.api.nvim_get_current_buf()
    local new_buf = vim.api.nvim_create_buf(false, true);
    local new_win = vim.api.nvim_open_win(new_buf, false, { vertical = true });
    local expanded_args = vim.iter(ipairs(args.fargs)):map(function(_, a) return vim.fn.expandcmd(a) end):totable()
    run_cmd_to_buf(expanded_args, new_buf)
    vim.api.nvim_create_autocmd("BufWritePost", {
        callback = function() run_cmd_to_buf(expanded_args, new_buf) end,
        buffer = current_buf,
        group = grp,
    })
end

command("Watch", watch, { nargs = "+", complete = "shellcmd" })
