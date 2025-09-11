-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.default_prog = { 'nu' }

local scheme = 'Tokyo Night'
local scheme_def = wezterm.color.get_builtin_schemes()[scheme]
config.color_scheme = scheme
-- config.colors = {
--   tab_bar = scheme_def.tab_bar
-- }

-- Window decorations
config.window_decorations = "RESIZE"
config.window_frame = {
        inactive_titlebar_bg = "none",
        active_titlebar_bg = "none",
}

-- Tab bar
config.tab_bar_at_bottom = true
config.tab_max_width = 200
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false

config.keys = {
  {
    key = 'c',
    mods = 'ALT',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain',
  }
}

for i = 1, 8 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'ALT',
    action = wezterm.action.ActivateTab(i - 1),
  })
end

-- Finally, return the configuration to wezterm:
return config
