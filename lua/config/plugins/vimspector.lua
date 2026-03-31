return function()
    vim.g.vimspector_base_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy/vimspector")
    vim.g.vimspector_enable_mappings = 'HUMAN'
    vim.g.vimspector_enable_winbar = true
    vim.g.vimspector_configurations = {
        python = {
            adapter = 'debugpy',
            configuration = {
                type = 'python',
                request = 'launch',
                python = "${VIRTUAL_ENV}/bin/python",
                cwd = "${fileDirname}",
                justMyCode = false,
                args = {"*${Args}"},
                program = "${file}",
            },
            breakpoints = {
                exception = {
                    raised = 'N',
                    caught = 'N',
                    uncaught = 'Y',
                    userUnhandled = 'N',
                },
            },
        },
    }
end
