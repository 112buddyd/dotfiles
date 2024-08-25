local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Mocha"

config.font = wezterm.font({
  family = "MesloLGL Nerd Font Mono",
  weight = "Medium",
})
config.font_size = 19

config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.9
-- config.macos_window_background_blur = 25

return config
