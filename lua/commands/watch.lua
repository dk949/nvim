local log = require("utils.log")
local command = vim.api.nvim_create_user_command


--- Run a command (as a table) asynchronously and pipe output into a buffer.
---@param cmd table
---@param bufnr number
---@return number job_id
local function run_cmd_to_buf(cmd, bufnr)
    if type(cmd) ~= "table" then error("cmd must be a table") end
    if not vim.api.nvim_buf_is_valid(bufnr) then error("invalid buffer id: " .. tostring(bufnr)) end
    vim.api.nvim_set_option_value("modifiable", true, { buf = bufnr })

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
        on_exit = function() vim.api.nvim_set_option_value("modifiable", false, { buf = bufnr }) end
    })
    if not job_id or job_id <= 0 then log.fatalf("failed to start job (jobstart returned %d)", job_id) end
    return job_id
end

---@param args string[]
---@return string[]
---@return table<string, any>
local function parseArgs(args)
    local opts = {}

    local found_start = false
    local new_args = vim.iter(ipairs(args))
        :filter(function(_, arg)
            if found_start then
                return true
            else
                local key, value = arg:match("^([^%s=]+)=([^%s=]+)$")
                if key == nil then
                    found_start = true
                    return true
                else
                    opts[key] = value
                    return false
                end
            end
        end)
        :map(function(_, arg) return vim.fn.expandcmd(arg) end)
        :totable()
    return new_args, opts
end

---@param args vim.api.keyset.create_user_command.command_args
local function watch(args)
    local grp = vim.api.nvim_create_augroup("dk949-watch", { clear = true })
    local current_buf = vim.api.nvim_get_current_buf()
    local parsed_args, opts = parseArgs(args.fargs)
    local target_buf = vim.api.nvim_create_buf(false, true);
    local target_win = vim.api.nvim_open_win(target_buf, false, { vertical = true });
    for key, value in pairs(opts) do
        if value == "true" then
            value = true
        elseif value == "false" then
            value = false
        end
        if not pcall(vim.api.nvim_set_option_value, key, value, { buf = target_buf }) then
            vim.api.nvim_set_option_value(key, value, { win = target_win })
        end
    end

    vim.api.nvim_set_option_value("modifiable", false, { buf = target_buf })
    run_cmd_to_buf(parsed_args, target_buf)
    vim.api.nvim_create_autocmd("BufWritePost", {
        callback = function() run_cmd_to_buf(parsed_args, target_buf) end,
        buffer = current_buf,
        group = grp,
    })
end

command("Watch", watch, { nargs = "+", complete = "shellcmd" })
