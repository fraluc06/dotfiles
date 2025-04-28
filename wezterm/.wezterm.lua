local wezterm = require 'wezterm'

return {
    -- Window Behavior
    window_decorations = "RESIZE",
    hide_tab_bar_if_only_one_tab = false,
    exit_behavior = "Close",
    adjust_window_size_when_changing_font_size = false,
    default_cursor_style = "BlinkingBlock",

    -- Mouse
    hide_mouse_cursor_when_typing = false,
    pane_focus_follows_mouse = false,
    mouse_scroll_multiplier = 1,
    mouse_bindings = {
        -- Single click moves the cursor
        { event = { Up = { streak = 1, button = "Left" } }, mods = "NONE", action = wezterm.action({ MouseMove = "PressLeft" }) },
    },

    -- Scrolling & Performance
    enable_scroll_bar = false,
    window_background_opacity = 1.0,

    -- Copy & Paste
    copy_on_select = true,
    clipboard = {
        trim_output_before_pasting = true,
        bracketed_paste = true,
        secure_paste = true,
    },

    -- Appearance: Colors & Theme (Catppuccin Mocha)
    color_scheme = "Catppuccin Mocha",
    colors = {
        foreground = "#cdd6f4",
        background = "#1e1e2e",
        cursor_bg = "#f5e0dc",
        cursor_fg = "#cdd6f4",
        selection_bg = "#585b70",
        selection_fg = "#cdd6f4",
        ansi = { "#45475a", "#f38ba8", "#a6e3a1", "#f9e2af", "#89b4fa", "#f5c2e7", "#94e2d5", "#a6adc8" },
        brights = { "#585b70", "#f37799", "#89d88b", "#ebd391", "#74a8fc", "#f2aede", "#6bd7ca", "#bac2de" },
    },
    bold_brightens_ansi_colors = false,

    -- Font
    font = wezterm.font_with_fallback({
        { family = "JetBrainsMono Nerd Font Mono",  weight = "Regular" },
        { family = "JetBrainsMono NFM Bold",        weight = "Bold" },
        { family = "JetBrainsMono NFM Italic",      style = "Italic" },
        { family = "JetBrainsMono NFM Bold Italic", weight = "Bold",   style = "Italic" },
    }),
    font_size = 16.0,

    -- Hyperlinks
    hyperlink_rules = wezterm.default_hyperlink_rules(),

    -- Window Frame & Padding
    window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
    window_frame = { active_titlebar_bg = "#1e1e2e" },
}
