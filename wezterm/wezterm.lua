local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.enable_wayland = false
config.hide_tab_bar_if_only_one_tab = true
config.color_scheme = "Tokyo Night"
config.font_size = 20
config.window_background_opacity = 0.97

return config
