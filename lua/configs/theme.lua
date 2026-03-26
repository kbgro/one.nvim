return {
  transparent = true,
  styles = {
    floats = 'transparent',
    sidebars = 'transparent',
  },
  on_colors = function(colors)
    -- Override Git colors
    local git_color = {
      add = '#28a745',
      change = '#007bff',
      delete = '#dc3545',
    }
    colors.git = git_color
    colors.gitSigns = git_color
  end,
  on_highlights = function(hl, c)
    -- Normal & floating windows
    hl.Normal = { bg = 'none' }
    hl.NormalFloat = { bg = 'none' }

    -- Cursor line
    hl.CursorLine = { bg = '#010b17' }

    -- Status line
    hl.StatusLine = { bg = 'none' }

    -- Diagnostic virtual text
    hl.DiagnosticVirtualTextError.bg = 'none'
    hl.DiagnosticVirtualTextWarn.bg = 'none'
    hl.DiagnosticVirtualTextInfo.bg = 'none'
    hl.DiagnosticVirtualTextHint.bg = 'none'
  end,
}
