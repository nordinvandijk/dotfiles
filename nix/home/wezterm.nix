{ lib, pkgs, ...}: {
  programs.wezterm = {
  enable = true;
  extraConfig = ''
    local wezterm = require 'wezterm'
    local config = wezterm.config_builder()

    local scheme = 'Tokyo Night'
    config.color_scheme = scheme

    -- Tab bar (multiplexing is handled by herdr)
    config.enable_tab_bar = false
  '' + lib.optionalString pkgs.stdenv.hostPlatform.isDarwin ''

    -- Window decorations
    config.window_decorations = "RESIZE"
    config.window_frame = {
      inactive_titlebar_bg = "none",
      active_titlebar_bg = "none",
    }

    config.max_fps = 120
  '' + lib.optionalString pkgs.stdenv.hostPlatform.isLinux ''

    config.default_prog = { 'nu' }

    -- Window decorations
    -- Let WSLg/Windows handle window decorations natively via RDP RAIL
    config.window_decorations = "NONE"

    -- Renderer (OpenGL is more stable than WebGPU on WSLg, avoids resize lag)
    config.front_end = "OpenGL"
  '' + ''

    return config
  '';
};
}
