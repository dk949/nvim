local api = vim.api
local fn = vim.fn

api.nvim_create_user_command("W", "w", {})
api.nvim_create_user_command("E", "e", {})

function deleteView()
    local path = fn.fnamemodify(fn.bufname('%'), ':p')
    path = fn.substitute(path, '=', '==', 'g')
    if vim.env.HOME then path = fn.substitute(path, '^' .. vim.env.HOME, '~', '') end
    path = fn.substitute(path, '/', '=+', 'g') .. '='
    path = vim.o.viewdir .. "/" .. path
    fn.delete(path)
    print("Deleted ", path)
    dk949.nomkview = true
end

api.nvim_create_user_command("Delview", function() deleteView() end, {})

-- Lower-case user commands: http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
vim.cmd[[cabbrev delview <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Delview' : 'delview')<CR>]]

api.nvim_create_user_command("EchoHl", [[echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . '> lo<' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"]], {})
