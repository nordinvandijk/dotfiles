# Unpacked Chrome extension that hides elements per site.
# One-time setup: chrome://extensions -> Developer mode -> Load unpacked -> ~/.config/chrome-hide-elements
# After a rebuild, click reload on the extension (or restart Chrome).
{lib, ...}: let
  # domain (subdomains included) -> CSS selectors to hide
  hideRules = {
    # "example.com" = [".cookie-banner" "#sidebar-ads"];
    "youtube.com" = [
      "ytd-feed-filter-chip-bar-renderer"
      "ytd-rich-grid-renderer > #header chip-bar-view-model"
    ];
  };

  extDir = ".config/chrome-hide-elements";
  cssName = domain: "${lib.replaceStrings ["."] ["_"] domain}.css";
in {
  home.file =
    {
      "${extDir}/manifest.json".text = builtins.toJSON {
        manifest_version = 3;
        name = "Hide elements (nix)";
        version = "1.0";
        content_scripts =
          lib.mapAttrsToList (domain: _: {
            matches = ["*://${domain}/*" "*://*.${domain}/*"];
            css = [(cssName domain)];
            run_at = "document_start";
          })
          hideRules;
      };
    }
    // lib.mapAttrs' (domain: selectors:
      lib.nameValuePair "${extDir}/${cssName domain}" {
        text = "${lib.concatStringsSep ",\n" selectors} { display: none !important; }\n";
      })
    hideRules;
}
