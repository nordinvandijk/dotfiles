# Unpacked Chrome extension that hides elements per site.
# One-time setup: chrome://extensions -> Developer mode -> Load unpacked -> ~/.config/chrome-hide-elements
# After a rebuild, click reload on the extension (or restart Chrome).
{
  lib,
  pkgs,
  inputs,
  ...
}: let
  # domain (subdomains included) -> CSS selectors to hide
  hideRules = {
    # "example.com" = [".cookie-banner" "#sidebar-ads"];
    "youtube.com" = [
      "ytd-feed-filter-chip-bar-renderer"
      "ytd-rich-grid-renderer > #header chip-bar-view-model"
      "ytd-mini-guide-entry-renderer.ytd-mini-guide-renderer.style-scope:nth-of-type(2)"
      "yt-chip-cloud-renderer"
      ''a[href="/feed/channels"]''
    ];
  };

  extDir = ".config/chrome-hide-elements";
  extension = pkgs.callPackage "${inputs.self}/packages/chrome-hide-elements" {inherit hideRules;};
in {
  home.activation.chromeHideElements = lib.hm.dag.entryAfter ["linkGeneration"] ''
    run rm -rf "$HOME/${extDir}"
    run mkdir -p "$HOME/${extDir}"
    run cp ${extension}/* "$HOME/${extDir}/"
    run chmod u+w "$HOME/${extDir}"/*
  '';
}
