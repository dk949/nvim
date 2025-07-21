require "utils".ftplugin(
    vim.tbl_deep_extend("error", require "config.common".prog, {
        formatprg = require("config.common.formatting").fortranProg,
    }),
    function()
        require "utils.lsp".enableLsp({
            config = "fortls",
            mason = { "fortls", "fprettify" },
        }, function(config)
            if not config then
                config = {
                    cmd = {
                        'fortls',
                        '--hover_signature',
                        '--hover_language=fortran',
                        '--use_signature_help',
                    },
                }
            end
            return config
        end)
    end
)
