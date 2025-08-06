if vim.fn.argc(-1) == 0 and vim.fn.has('ttyin') == 1 then
    vim.cmd("doautocmd User Dk949Args0")
end
