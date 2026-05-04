local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Font
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 11.0
config.line_height = 1.2

-- Color scheme (Catppuccin Mocha)
config.color_scheme = "Catppuccin Mocha"

-- Window appearance
config.window_background_opacity = 0.88
config.macos_window_background_blur = 20
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_padding = {
  left = 4,
  right = 4,
  top = 4,
  bottom = 4,
}

-- Tab bar
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 25
config.show_new_tab_button_in_tab_bar = true
config.colors = {
  tab_bar = {
    background = "#11111B",
    active_tab = {
      bg_color = "#1E1E2E",
      fg_color = "#FFFFFF",
      intensity = "Bold",
      italic = true,
    },
    inactive_tab = {
      bg_color = "#45475A",
      fg_color = "#C2C2C2",
    },
    new_tab = {
      bg_color = "#45475A",
      fg_color = "#CDD6F4",
    },
  },
}

-- Terminal
config.term = "xterm-256color"
config.enable_wayland = false
config.audible_bell = "Disabled"
config.default_prog = { "/bin/zsh" }

-- macOS: Option key as Alt for Neovim Meta keybindings
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = true

-- Keybindings
local act = wezterm.action
config.keys = {
  -- Pane navigation (matches tmux/neovim Ctrl+h/j/k/l)
  { key = "h", mods = "CTRL", action = act.SendKey({ key = "h", mods = "CTRL" }) },
  { key = "j", mods = "CTRL", action = act.SendKey({ key = "j", mods = "CTRL" }) },
  { key = "k", mods = "CTRL", action = act.SendKey({ key = "k", mods = "CTRL" }) },
  { key = "l", mods = "CTRL", action = act.SendKey({ key = "l", mods = "CTRL" }) },
}

-- Scrollback
config.scrollback_lines = 50000

-- Cursor
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500
config.animation_fps = 1

-- Inactive pane dimming (useful with tmux splits)
config.inactive_pane_hsb = {
  saturation = 0.85,
  brightness = 0.7,
}

-- URL detection
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- Performance
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

-- Normalize key input for tmux/neovim (disable default WezTerm binds that conflict)
config.disable_default_key_bindings = false

return config
