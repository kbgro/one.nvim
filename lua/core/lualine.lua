local lualine = require "lualine"
local icons = require "core.icons"

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = {
    error = icons.diagnostics.Error,
    warn = icons.diagnostics.Warn,
    info = icons.diagnostics.Info,
    hint = icons.diagnostics.Hint,
  },
}

local filetype = {
  "filetype",
  icon_only = true,
  separator = "",
  padding = { left = 1, right = 0 },
}

local filename = {
  "filename",
  path = 1,
  symbols = { modified = "  ", readonly = "", unnamed = "" },
}

local location = {
  "location",
  padding = 0,
}

local progress = { "progress", separator = " ", padding = { left = 1, right = 1 } }

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "auto",
    disabled_filetypes = { "alpha", "dashboard" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { diagnostics, filetype, filename },
    lualine_x = { spaces, "encoding" },
    lualine_y = { location },
    lualine_z = { progress },
  },
}
