{ lib, pkgs, ...}: {
  programs.wezterm = {
  enable = true;
  extraConfig = ''
    local wezterm = require 'wezterm'
    local config = wezterm.config_builder()

    config.default_prog = { 'nu' }

    local scheme = 'Tokyo Night'
    config.color_scheme = scheme

    -- Window decorations
    -- Let WSLg/Windows handle window decorations natively via RDP RAIL
    config.window_decorations = "NONE"

    -- Tab bar
    config.tab_bar_at_bottom = true
    config.tab_max_width = 200
    config.show_new_tab_button_in_tab_bar = false
    config.use_fancy_tab_bar = false

    -- Renderer (OpenGL is more stable than WebGPU on WSLg, avoids resize lag)
    config.front_end = "OpenGL"

    -- Keys
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

    return config
  '';
};
}
