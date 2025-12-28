return {
    "nvim-lua/plenary.nvim",
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        lazy = true,
        opts = function()
            return require("configs.theme")
        end,
        init = function()
            vim.cmd.colorscheme 'tokyonight-night'
        end
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("lualine").setup(require("configs.lualine"))
        end
    },

    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = function()
            return require "configs.nvimtree"
        end,
    },

    {
        "numToStr/Comment.nvim",
        opts = {},
        config = function()
            local comment = require "Comment"
            comment.setup(require("configs.comment"))
        end
    },

    {
        "lewis6991/gitsigns.nvim",
        opts = function()
            return require "configs.gitsigns"
        end,
    },

    {
        "mason-org/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUpdate" },
        opts = function()
            -- return require "configs.mason"
        end,
    },

    {
        "neovim/nvim-lspconfig",
        -- event = "User FilePost",
        dependencies = {
            { 'williamboman/mason.nvim',          config = true },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'j-hui/fidget.nvim',                opts = {} },
        },
        config = function()
            require("configs.lspconfig").defaults()
        end,
    },

    -- load luasnips + cmp related in insert mode only
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                -- snippet plugin
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                dependencies = "rafamadriz/friendly-snippets",
                opts = { history = true, updateevents = "TextChanged,TextChangedI" },
                config = function(_, opts)
                    require("luasnip").config.set_config(opts)
                    require "configs.luasnip"
                end,
            },

            -- autopairing of (){}[] etc
            {
                "windwp/nvim-autopairs",
                opts = {
                    fast_wrap = {},
                    disable_filetype = { "TelescopePrompt", "vim" },
                },
                config = function(_, opts)
                    require("nvim-autopairs").setup(opts)

                    -- setup cmp for autopairs
                    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
                    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
                end,
            },

            -- cmp sources plugins
            {
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "https://codeberg.org/FelipeLema/cmp-async-path.git"
            }
        },
        opts = function()
            return require "configs.cmp"
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        event = 'VimEnter',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },
            { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
        },

        cmd = "Telescope",
        opts = function()
            return require("configs.telescope").opts
        end,
        config = function()
            require("configs.telescope").setup()
        end
    },

    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        main = 'nvim-treesitter.configs',         -- Sets main module to use for opts
        opts = function()
            return require "configs.treesitter"
        end,
    },

    {
        'vimwiki/vimwiki',
        init = function()
            require "configs.docs"
        end
    },

}
