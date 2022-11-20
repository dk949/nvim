return require("packer").startup(function()
    use "wbthomason/packer.nvim"
    use 'navarasu/onedark.nvim'
    use 'Mofiqul/dracula.nvim'
    use {'nvim-lualine/lualine.nvim', requires = { 'ryanoasis/vim-devicons', 'nvim-tree/nvim-web-devicons'}}
end)
