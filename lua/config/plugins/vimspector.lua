return function()
    vim.g.vimspector_base_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy/vimspector")
    vim.g.vimspector_enable_mappings = 'HUMAN'
    vim.g.vimspector_enable_winbar = true
end
