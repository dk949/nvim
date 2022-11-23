require('utils')
local fn = vim.fn
local fs = vim.fs

if not fn.isdirectory(fn.stdpath('data')..'/site/pack/packer/start/packer.nvim') then
    warnPrint("WARNING: packer.nvim not found. Trying to download...")
    fn.system("git clone --depth 1 https://github.com/wbthomason/packer.nvim " .. fn.stdpath('data') .."/site/pack/packer/start/packer.nvim")
    if v.shell_error ~= 0 then errPrint("ERROR: packer.nvim could not be downloaded") end
end

localPlugins = {}
for file in fs.dir(fn.stdpath("config") .. "/lua/localPlugins") do
    pack = string.gsub(file, ".lua", "")
    localPlugins[pack] = require("localPlugins."..pack)
end


return require("packer").startup(function()
    --Packer
    use "wbthomason/packer.nvim"

    -- statusline
    use {'nvim-lualine/lualine.nvim', requires = { 'ryanoasis/vim-devicons', 'nvim-tree/nvim-web-devicons'}}

    -- Themes
    use 'Mofiqul/dracula.nvim'
    use 'navarasu/onedark.nvim'

    -- QoL
    use 'machakann/vim-highlightedyank'
    use {'preservim/nerdcommenter', ft = dk949.codeft}
    use 'preservim/nerdtree'
    use 'tpope/vim-surround'
    use 'zivyangll/git-blame.vim'
    use 'godlygeek/tabular'
    use 'wfxr/minimap.vim'
    use {'lukas-reineke/indent-blankline.nvim', ft = dk949.codeft} -- only load if in a code file

    -- telescope
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'


    -- Lsp

    use {'hrsh7th/nvim-cmp', as="cmp"                      , ft = dk949.codeft} -- Autocompletion plugin
    use {'L3MON4D3/LuaSnip', as="snip"                     , ft = dk949.codeft} -- Snippets plugin
    use {'hrsh7th/cmp-nvim-lsp', as="cmp-lsp"              , ft = dk949.codeft} -- LSP source for nvim-cmp
    use {'saadparwaiz1/cmp_luasnip', as="cmp-snip"         , ft = dk949.codeft} -- Snippets source for nvim-cmp
    use {'neovim/nvim-lspconfig', after = {"cmp", "snip", "cmp-lsp", "cmp-snip"} , config = function() LSPConfigFn() end}

    -- Language support
    use 'aklt/plantuml-syntax'
    use 'maxbane/vim-asm_ca65'
    use {'plasticboy/vim-markdown', ft = "markdown" }
    use {'jackguo380/vim-lsp-cxx-highlight', ft={"c","cpp"}}
    use {'ziglang/zig.vim'}

    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}


    use {'vimwiki/vimwiki', ft = 'vimwiki'}
end)


