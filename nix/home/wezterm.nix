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

    -- Tab bar (multiplexing is handled by herdr)
    config.enable_tab_bar = false

    -- Renderer (OpenGL is more stable than WebGPU on WSLg, avoids resize lag)
    config.front_end = "OpenGL"

    return config
  '';
};
}
