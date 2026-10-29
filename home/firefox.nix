{...}: {
  programs.firefox = {
    enable = true;
    policies = {
      ExtensionSettings."uBlock0@raymondhill.net" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        installation_mode = "force_installed";
        private_browsing = true;
      };
      "3rdparty".Extensions."uBlock0@raymondhill.net".toOverwrite.filters = [
        "youtube.com##ytd-feed-filter-chip-bar-renderer"
        "youtube.com##ytd-rich-grid-renderer > #header chip-bar-view-model"
        "youtube.com##ytd-mini-guide-entry-renderer.ytd-mini-guide-renderer.style-scope:nth-of-type(2)"
      ];
    };
  };
}
