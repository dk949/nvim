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
