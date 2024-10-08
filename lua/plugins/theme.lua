local pipe_icon = '▌'

return {
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        lazy = true,
        opts = {
            transparent = true,
            styles = {
                floats = "transparent",
                sidebars = "transparent",
            },
            on_colors = function(colors)
                local git_color = { add = "#28a745", change = "#007bff", delete = "#dc3545" }
                colors.git = git_color
                colors.gitSigns = git_color
            end
        },
        init = function()
            vim.cmd.colorscheme 'tokyonight-night'
        end
    },

    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = pipe_icon },
                change = { text = pipe_icon },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = pipe_icon },
                untracked = { text = pipe_icon },
            },
            signs_staged = {
                add = { text = pipe_icon },
                change = { text = pipe_icon },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = pipe_icon },
            },
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end

                -- stylua: ignore start
                map("n", "]h", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gs.nav_hunk("next")
                    end
                end, "Next Hunk")
                map("n", "[h", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gs.nav_hunk("prev")
                    end
                end, "Prev Hunk")
                map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
                map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
                map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
                map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
                map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
                map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
                map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
                map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
                map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
                map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
                map("n", "<leader>ghd", gs.diffthis, "Diff This")
                map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
            end,
        },
    }
}
