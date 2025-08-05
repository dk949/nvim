require "utils".ftplugin(
    require "config.common".prog:with {
        formatprg = require("config.common.formatting").fortranProg,
    },
    function()
        require "utils.lsp".enableLspTools({
            config = "fortls",
            mason = { "fortls", "fprettify" },
        }, {
            override = function(config)
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
            end
        })
    end
)
