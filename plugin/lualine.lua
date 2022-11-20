local branch = {'branch'}           -- git branch
local buffers = { 'buffers',
    show_filename_only = true,
    show_modified_status = true,

    mode = 0,
    symbols = {
        modified = ' ✦',
        alternate_file = '# ',
    }
}
local diagnostics = {'diagnostics'} -- diagnostics count from your preferred source
local diff = {'diff'}               -- git diff status
local encoding = {'encoding'}       -- file encoding
local fileformat = {'fileformat', icons_enabled = true }
local filename = {'filename', newfile_status = true, path = 1 }
local filesize = {'filesize'}
local filetype = {'filetype', icon_only = false, colored = true }
local hostname = {'hostname'}
local location = {'location'}       -- location in file in line:column format
local mode = {'mode'}               -- vim mode
local progress = {'progress'}       -- %progress in file
local searchcount = {'searchcount'} -- number of search matches when hlsearch is active
local tabs = {'tabs'}              -- shows currently available tabs
local windows = {'windows'}        -- shows currently available windows

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { branch, diff, diagnostics },
    lualine_c = { filename },
    lualine_x = { encoding, fileformat, filetype },
    lualine_y = { progress },
    lualine_z = { location }
  },
  inactive_sections = {
    lualine_a = { },
    lualine_b = { },
    lualine_c = { filename },
    lualine_x = { location },
    lualine_y = { },
    lualine_z = { }
  },
  tabline = {
      lualine_a = {buffers},
      lualine_z = {tabs}
  },
  inactive_winbar = {},
  extensions = {}
}






