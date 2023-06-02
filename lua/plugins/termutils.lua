return {
    'dk949/termutils.nvim',
    config = function()
        require('termutils').setup({startinsert = false});
    end
}
