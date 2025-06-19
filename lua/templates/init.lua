--- TODO(dk949): This is pretty bad.
---              Consider a simpler templating.


local id = function(x) return x end
local function doSan(x) return x:gsub("[%s.,:;|%-/\\]", "_") end
local function doCap(x) return x:upper() end
local function doNoCap(x) return x:lower() end

local PATTERNS = {
    FILE = function() return vim.fn.expand("%:t") end,
    NO_SRC_DIR = function()
        local this_dir = vim.fs.basename(vim.fn.getcwd())
        local file_dir = vim.fn.expand("%:h")
        local dir = "./" .. vim.fs.normalize(vim.fs.joinpath(this_dir, file_dir)) .. "/"
        local out = dir:gsub("/src/", "/"):sub(3)
        return out
    end,
}
local TEMPLATES = {
    "%SAN_FILE_CAP%",
    "%SAN_NO_SRC_DIR%",
    "%SAN_NO_SRC_DIR_CAP%",
}


--- TODO(dk949): rewrite this to search all template directories
---Apply a function to every file in the directory except this one
---@param fn fun(name:string, file:string):any
local function foreach_file(fn)
    local source = debug.getinfo(1, "S").source
    local script_path = source:sub(2)

    local dir_path = script_path:match("^(.*[/\\])") or "./"
    dir_path = dir_path:gsub("[/\\]$", "")

    for name, entry_type in vim.fs.dir(dir_path, {}) do
        if entry_type == "file" and name ~= "init.lua" then
            fn(name, vim.fs.joinpath(dir_path, name))
        end
    end
end

local grp = vim.api.nvim_create_augroup("templates", {})


---@param pat string
local function stripModifiers(pat)
    local out = pat
        :gsub("^%%SAN_(.*)$", "%1")
        :gsub("^(.*)_CAP%%$", "%1")
        :gsub("^(.*)_NOCAP%%$", "%1")
        :gsub("^%%(.*)$", "%1")
        :gsub("^(.*)%%$", "%1")
    return out
end


local function run(str, pat)
    if str == "" then return str end
    local san = id
    local cap = id
    local nocap = id
    if vim.startswith(pat, "%SAN_") then
        san = doSan
    end
    if vim.endswith(pat, "_CAP%") then
        cap = doCap
    elseif vim.endswith(pat, "_NOCAP%") then
        nocap = doNoCap
    end
    local nomod = stripModifiers(pat)
    local replacement = PATTERNS[nomod]()
    local post_tranofrm = cap(nocap(san(replacement))):gsub("%%", "%%%%")
    pat = pat:gsub("%%", "%%%%")
    local out = str:gsub(pat, post_tranofrm)
    return out
end

local function doSub(c)
    for i = 1, #c do
        for _, t in ipairs(TEMPLATES) do
            c[i] = run(c[i], t)
        end
    end
end

local function runTemplates(file)
    local contents = vim.fn.readfile(file)
    doSub(contents)
    vim.api.nvim_put(contents, "", false, false)
    vim.fn.search("%CURSOR%")
    vim.cmd "s/%CURSOR%//eg"
end

foreach_file(function(name, file)
    vim.api.nvim_create_autocmd("BufNewFile", {
        pattern = name:gsub("%%", "*"),
        group = grp,
        callback = function() runTemplates(file) end
    })
end)
