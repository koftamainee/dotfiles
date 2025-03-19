local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.enable_wayland = false
config.color_scheme = "Tokyo Night"
config.enable_tab_bar = false
config.font = wezterm.font("monospace")
config.font_size = 20
config.window_background_opacity = 0.97
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "NONE"

config.window_padding = {
	left = "0px",
	right = "0px",
	top = "0px",
	bottom = "0px",
}

return config
