local uv = vim.uv
local utils = require("utils")
local o = utils.o
local M = {}

local function readFileSync(path)
    local fd = assert(uv.fs_open(path, "r", o '666'))
    local stat = assert(uv.fs_fstat(fd))
    local data = assert(uv.fs_read(fd, stat.size, 0))
    assert(uv.fs_close(fd))
    return data
end

function M.readFile(path, callback)
    if not callback then return readFileSync(path) end

    uv.fs_open(path, "r", o '666', function(err, fd)
        if err then
            callback(err)
            return
        end
        uv.fs_fstat(fd, function(err, stat)
            if err then
                callback(err)
                assert(uv.fs_close(fd))
                return
            end
            uv.fs_read(fd, stat.size, 0, function(err, data)
                if err then
                    callback(err)
                    assert(uv.fs_close(fd))
                    return
                end
                uv.fs_close(fd, function(err)
                    if err then
                        callback(err)
                        return
                    end
                    return callback(nil, data)
                end)
            end)
        end)
    end)
end

local function writeFileSync(path, data)
    local fd = assert(uv.fs_open(path, "w", o '666'))
    assert(uv.fs_write(fd, data, 0))
    assert(uv.fs_close(fd))
end

function M.writeFile(path, data, callback)
    if not callback then return writeFileSync(path, data) end

    uv.fs_open(path, "w", o '666', function(err, fd)
        if err then
            callback(err)
            return
        end
        uv.fs_write(fd, data, 0, function(err, written)
            if err then
                callback(err)
                assert(uv.fs_close(fd))
            end
            uv.fs_close(fd, function(err)
                if err then
                    callback(err)
                    return
                end
                callback(nil, written)
            end)
        end)
    end)
end

return M
