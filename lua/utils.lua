-- Create and populate an autogroup
function augroup(name, opts)
    --clear by default
    local clear = true
    if opts.clear then clear = opts.clear end

    grp = vim.api.nvim_create_augroup(name, { clear = clear })
    opts.clear = nil
    for k,v in pairs(opts) do
        v.group = grp
        vim.api.nvim_create_autocmd(k, v)
    end
end

-- Return a callback to set vim options
function setter(opts)
    return function()
        for opt, val in pairs(opts) do
            vim.o[opt] = val
        end
    end
end

function hlPrint(hl, ...)
    local arg={...}
    local text = {}
    for i,v in ipairs(arg) do
        text[i] = ({tostring(v), hl})
    end
    vim.api.nvim_echo(text, true, {})
end

function warnPrint(...)
    hlPrint("WarningMsg", ...)
end

function errPrint(...)
    hlPrint("ErrorMsg", ...)
end
