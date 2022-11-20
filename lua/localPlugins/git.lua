require("utils")

local fn = vim.fn
local api = vim.api

local function cmd(...)
    local args = {...}
    local arg = ""
    for _, a in ipairs(args) do
        arg = arg .. " " .. a
    end
    local out = fn.system("git " .. arg)
    if vim.v.shell_error ~= 0 then err = vim.v.shell_error end
    return out, err
end

local function getFilename(filename)
    return cmd("ls-files", "--full-name", filename)
end


local function readOld(filename, ref)
    assert(filename ~= nil, "file name cannot be nil")
    assert(ref ~= nil, "ref cannot be nil")
    return cmd("cat-file", "blob", ref .. ':' .. filename)
end

local function editOld(opts)
    if opts == nil then opts = {} end
    local filename = opts.filename
    local ref = opts.ref
    local diff = opts.diff

    if filename == nil then
        filename, err = getFilename(fn.expand("%:p"))
        if err then errPrint("Could not get old version of file") end
    end
    if ref == nil then ref = "HEAD" end
    if diff == nil then diff = false end
    local contents = readOld(filename, ref)
    local ft = api.nvim_buf_get_option(0,"filetype")

    if diff then vim.cmd[[diffthis]] end
    local win, buf = openWindow({vert = true})

    api.nvim_buf_set_name(buf, ref .. ":" .. stripString(filename))
    api.nvim_buf_set_lines(buf, 0, 0, false, fn.split(contents, "\n" ,true))
    api.nvim_buf_set_option(buf, "filetype", ft)
    if diff then vim.cmd[[diffthis]] end
end

return {
    cmd = cmd,
    getFilename = getFilename,
    readOld = readOld,
    editOld = editOld,
}
