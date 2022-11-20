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
    use "wbthomason/packer.nvim"
    use 'navarasu/onedark.nvim'
    use 'Mofiqul/dracula.nvim'
    use {'nvim-lualine/lualine.nvim', requires = { 'ryanoasis/vim-devicons', 'nvim-tree/nvim-web-devicons'}}
end)
