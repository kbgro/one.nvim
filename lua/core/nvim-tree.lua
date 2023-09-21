local nvim_tree = require "nvim-tree"
local icons = require "core.icons"

local git_icons = icons.git

nvim_tree.setup {
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  renderer = {
    root_folder_modifier = ":t",
    icons = {
      glyphs = {
        default = icons.fs.file.default,
        symlink = icons.fs.file.symlink,
        folder = icons.fs.folder,
        git = {
          unstaged = git_icons.unstaged,
          staged = git_icons.staged,
          unmerged = git_icons.unmerged,
          renamed = git_icons.renamed,
          untracked = git_icons.untracked,
          deleted = git_icons.deleted,
          ignored = git_icons.ignored,
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = icons.diagnostics.Hint,
      info = icons.diagnostics.Info,
      warning = icons.diagnostics.Warn,
      error = icons.diagnostics.Error,
    },
  },
  view = {
    width = 24,
    side = "right",
  },
}
