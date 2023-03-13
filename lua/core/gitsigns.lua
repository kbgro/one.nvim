local gitsigns = require "gitsigns"
local icons = require "core.icons"

gitsigns.setup {
  signs = {
    add = { text = icons.git.added },
    change = { text = icons.git.changed },
    delete = { text = icons.git.deleted },
    topdelete = { text = icons.git.deleted },
    changedelete = { text = icons.git.changed },
    untracked = { text = icons.git.added },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
}
