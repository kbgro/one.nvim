
return {
    transparent = true,
    styles = {
        floats = "transparent",
        sidebars = "transparent",
    },
    on_colors = function(colors)
        local git_color = {
            add = "#28a745",
            change = "#007bff",
            delete = "#dc3545"
        }
        colors.git = git_color
        colors.gitSigns = git_color
    end,
    on_highlights = function(hl, c)
        hl.CursorLine = { bg = "#010b17" }
        hl.StatusLine = { bg = "none" }
    end
}
