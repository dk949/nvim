-- https://github.com/puremourning/vimspector


-- F5          ->    When debugging, continue. Otherwise start debugging.
-- F3          ->    Stop debugging.
-- F4          ->    Restart debugging with the same configuration.
-- F6          ->    Pause debuggee.
-- <leader>F6  ->    Disassemble
-- F9          ->    Toggle line breakpoint on the current line.
-- <leader>F9  ->    Toggle conditional line breakpoint or logpoint on the current line.
-- F8          ->    Add a function breakpoint for the expression under cursor
-- <leader>F8  ->    Run to Cursor
-- F10         ->    Step Over
-- F11         ->    Step Into
-- F12         ->    Step out of current function scope

vim.g.vimspector_enable_mappings = 'HUMAN'
vim.g.vimspector_enable_winbar = true
return { "puremourning/vimspector", ft = { "c", "cpp" } }
