local M = {
  diagnostics = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
  },
  git = {
    added = "",
    changed = "",
    deleted = "",
    unstaged = "",
    staged = "S",
    unmerged = "",
    renamed = "➜",
    untracked = "U",
    ignored = "◌",
  },
  fs = {
    file = {
      default = "",
      symlink = "",
    },
    folder = {
      arrow_open = "",
      arrow_closed = "",
      default = "",
      open = "",
      empty = "",
      empty_open = "",
      symlink = "",
      symlink_open = "",
    },
  },
}

return M
