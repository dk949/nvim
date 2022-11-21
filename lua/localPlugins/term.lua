local api = vim.api
local function makeTerm()
    local w = api.nvim_win_get_width(0)
    local h = api.nvim_win_get_height(0)
    if(w <= h*2) then -- correcting for character aspet ratio
        vim.cmd[[split]]
    else
        vim.cmd[[vert split]]
    end
    vim.cmd[[term]]
    vim.cmd[[startinsert]]
end

return {
    makeTerm = makeTerm
}
