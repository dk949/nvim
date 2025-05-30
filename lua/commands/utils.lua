local M = {}

---Add an abbreviated command such that it does not get replaced in other contexts
---http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
---@param new string
---@param old string
function M.addAbrev(new, old, opts)
    local range_regex = [[%(%([0-9]+)<Bar>%(''[^,]))]]
    local range_1_regex = [[\v^]] .. range_regex .. [[$]]
    local range_2_regex = [[\v^]] .. range_regex .. "," .. range_regex .. [[$]]

    if opts == nil then opts = {} end

    local test = [[getcmdtype()==':' && (getcmdpos()==1 ]]
    if opts.range1 then test = test .. " <Bar><Bar> (match(getcmdline(), '" .. range_1_regex .. "') == 0)" end
    if opts.range2 then test = test .. " <Bar><Bar> (match(getcmdline(), '" .. range_2_regex .. "') == 0)" end
    test = test .. ")"

    vim.cmd.cabbrev(new .. " <c-r>" .. "=(" .. test .. " ? '" .. old .. "' : '" .. new .. "')<CR>")
end

return M
