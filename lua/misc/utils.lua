-- Extended API

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

function wincmd(cmd)
    vim.cmd("wincmd " .. cmd)
end

function fnOrVal(val)
   if type(val) == 'function' then
       return val()
   else
       return val
   end
end


function switch(on)
    return function(stmt)
        if stmt[on] ~= nil then
            return fnOrVal(stmt[on])
        else
            return sfnOrVal(tmt.__default)
        end
    end
end



-- Callback generation

function setter(opts)
    return function()
        for opt, val in pairs(opts) do
            vim.o[opt] = val
        end
    end
end

function cmdCB(cmd)
    return function()
        return vim.cmd(cmd)
    end
end


-- Printing

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
