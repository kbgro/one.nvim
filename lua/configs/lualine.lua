local colors = {
    bg_dark   = "#1f2335",
    magenta   = "#bb9af7",
    fg_dark   = '#a9b1d6',
    fg_gutter = "#bd93f9",
    blue      = '#7aa2f7',
    gray      = '#44475a',
    lightgray = '#5f6a8e',
    orange    = '#ffb86c',
    purple    = '#bd93f9',
    red       = '#ff5555',
    yellow    = '#f1fa8c',
    green     = '#50fa7b',
    white     = '#f8f8f2',
    black     = '#282a36',
}

local lualine_theme = {
    normal = {
        a = { fg = colors.blue, gui = 'bold' },
        b = { fg = colors.purple },
        c = { fg = colors.fg_dark, gui = 'italic' },
    },
    insert = {
        a = { fg = colors.green, gui = 'bold' },
        b = { fg = colors.fg_gutter },
    },
    visual = {
        a = { fg = colors.magenta, gui = 'bold' },
        b = { fg = colors.fg_gutter },
    },
    replace = {
        a = { fg = colors.red, gui = 'bold' },
        b = { fg = colors.fg_gutter },
    },
    command = {
        a = { fg = colors.yellow, gui = 'bold' },
        b = { fg = colors.fg_gutter },
    },
    inactive = {
        a = { fg = colors.blue },
        b = { fg = colors.fg_gutter, gui = "bold" },
        c = { fg = colors.fg_gutter },
    },
}

M = {
    options = {
        globalstatus = true,
        icons_enabled = true,
        theme = lualine_theme,
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
}

return M
