local fn = vim.fn
local function dict(word)
    local out = fn.system([[curl -s dict://dict.org/d:]]..word..[[ | awk '!/[0-9]/' | sed 's/\r//g']])
    assert(vim.v.shell_error == 0, "Could not submit request to dict.org")
    return out
end

return dict
