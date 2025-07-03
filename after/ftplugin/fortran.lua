require "utils".ftplugin(
    require "config.common".prog,
    function()
        require "utils.lsp".enableLsp("fortls", function(config)
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
