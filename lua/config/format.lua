return {
    -- t: Auto-wrap text using 'textwidth'
    -- c: Auto-wrap comments using 'textwidth', inserting the current comment
    --    leader automatically.
    -- r: Automatically insert the current comment leader after hitting <Enter>
    --    in Insert mode.
    -- q: Allow formatting of comments with "gq".
    -- n: When formatting text, recognize numbered lists.
    -- 1 Don't break a line after a one-letter word.
    -- j: Where it makes sense, remove a comment leader when joining lines.
    -- l: Long lines are not broken in insert mode: When a line was longer than
    --    'textwidth' when the insert command started, Vim does not
    --    automatically format it.
    text = "tcrqn1jl",

    -- j: Where it makes sense, remove a comment leader when joining lines.
    -- c: Auto-wrap comments using 'textwidth', inserting the current comment
    --    leader automatically.
    -- r: Automatically insert the current comment leader after hitting <Enter>
    --    in Insert mode.
    -- q: Allow formatting of comments with "gq".
    -- l: Long lines are not broken in insert mode: When a line was longer than
    --    'textwidth' when the insert command started, Vim does not
    --    automatically format it.
    prog = "jcrql",
}
