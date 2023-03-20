-- git@github.com:junegunn/goyo.vim.git
vim.g.goyo_width = "80"
vim.g.goyo_height = "100%"
vim.g.goyo_linenr = false
return {
    'junegunn/goyo.vim',
    ft = require("lang_features").feat.goyo_mode,
}
