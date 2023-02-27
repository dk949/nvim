vim.g.ale_disable_lsp = true
vim.g.ale_virtualtext_cursor = false -- it's distracting in combination with the lsp virtual text
vim.g.ale_linters_explicit = true -- Only run linters named in ale_linters settings.
vim.g.ale_linters = {
    sh = { 'shellcheck' },
}
return { "dense-analysis/ale" }
