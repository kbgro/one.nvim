-- [[ editor config; lualine; treesitter ]]

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

return {
    {
        -- cpp
        'eriks47/generate.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' }
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("lualine").setup({
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
            })
        end
    },

    {
        'windwp/nvim-ts-autotag',
        config = function()
            require("nvim-ts-autotag").setup {
                opts = {
                    enable_close = true,          -- Auto close tags
                    enable_rename = true,         -- Auto rename pairs of tags
                    enable_close_on_slash = false -- Auto close on trailing </
                }
            }
        end
    },

    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        main = 'nvim-treesitter.configs', -- Sets main module to use for opts
        -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
        opts = {
            -- Add languages to be installed here that you want installed for treesitter
            ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash', 'dart', "html", "xml", "yaml", "json", "cmake", "css"},

            -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
            auto_install = false,
            -- Install languages synchronously (only applied to `ensure_installed`)
            sync_install = false,
            -- List of parsers to ignore installing
            ignore_install = {},
            -- You can specify additional Treesitter modules here: -- For example: -- playground = {--enable = true,-- },
            modules = {},
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<c-space>',
                    node_incremental = '<c-space>',
                    scope_incremental = '<c-s>',
                    node_decremental = '<M-space>',
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ['aa'] = '@parameter.outer',
                        ['ia'] = '@parameter.inner',
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        [']m'] = '@function.outer',
                        [']c'] = '@class.outer',
                    },
                    goto_next_end = {
                        [']M'] = '@function.outer',
                        [']C'] = '@class.outer',
                    },
                    goto_previous_start = {
                        ['[m'] = '@function.outer',
                        ['[['] = '@class.outer',
                    },
                    goto_previous_end = {
                        ['[M'] = '@function.outer',
                        ['[C'] = '@class.outer',
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ['<leader>a'] = '@parameter.inner',
                    },
                    swap_previous = {
                        ['<leader>A'] = '@parameter.inner',
                    },
                },
            }
        },
        -- There are additional nvim-treesitter modules that you can use to interact
        -- with nvim-treesitter. You should go explore a few and see what interests you:
        --
        --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
        --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
        --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    },
}
