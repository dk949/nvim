local utils = require("utils")

return function()
    if not vim.fn.isdirectory(vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim") then
        utils.warnPrint("WARNING: packer.nvim not found. Trying to download...")
        vim.fn.system("git clone --depth 1 https://github.com/wbthomason/packer.nvim " ..
        vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim")
        if vim.v.shell_error ~= 0 then
            errPrint("ERROR: packer.nvim could not be downloaded")
        end
    end
end
