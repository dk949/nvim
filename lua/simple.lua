return {
    source = function() vim.cmd [[source $XDG_CONFIG_HOME/vim/vimrc]] end,
    isRoot = function() return tonumber(vim.fn.system("id -u")) == 0 end
}
