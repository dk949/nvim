local serve_d_setup = false
return function()
    if not dk949.lsp_loaded then return end
    if not serve_d_setup then
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local lspconfig = require 'lspconfig'

        lspconfig.serve_d.setup {
            cmd = { "serve-d" },
            filetypes = { "d" },
            root_dir = lspconfig.util.root_pattern("dub.json", "dub.sdl", "*.d"),
            on_attach = nil,
            capabilities = capabilities,
        }
        serve_d_setup = true
    end
    require("code.common")()
    localPlugins.format.addFmt([[:silent execute "!dfmt -i %"]], vim.fn.bufnr())
    local save_cpo = vim.o.cpo
    vim.cmd [[set cpo&vim]]
    vim.opt_local.makeprg = "dub"
    vim.o.cpo = save_cpo


    vim.cmd [[DUDCDstartServer ]] -- start dcd
    vim.g.dutyl_dontHandleFormat = true
    vim.g.dutyl_dontHandleFormat = true
    vim.g.dutyl_neverAddClosingParen = true


    -- TODO: look at this
    vim.opt_local.errorformat = [[%f(%l\,%c): %t%m]]
end
