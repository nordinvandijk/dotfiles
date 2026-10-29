{pkgs, ...}: let
  clauthVersion = "0.16.0";
  clauthAssets = {
    aarch64-darwin = {
      name = "clauth-macos-aarch64";
      hash = "sha256-UhAwdzTKFll+hXEG9y7wBnU9Y2hk9hsqKVJU1OvosHk=";
    };
    x86_64-linux = {
      name = "clauth-linux-x86_64";
      hash = "sha256-U4sCM4ol5MymJBxfIHQqbtb7cS12+hPrRCw2OXLsyTM=";
    };
  };
  clauthAsset = clauthAssets.${pkgs.stdenv.hostPlatform.system};
  clauth = pkgs.stdenvNoCC.mkDerivation {
    pname = "clauth";
    version = clauthVersion;
    src = pkgs.fetchurl {
      url = "https://github.com/uwuclxdy/clauth/releases/download/v${clauthVersion}/${clauthAsset.name}";
      inherit (clauthAsset) hash;
    };
    dontUnpack = true;
    nativeBuildInputs =
      [pkgs.makeWrapper]
      ++ pkgs.lib.optionals pkgs.stdenv.hostPlatform.isLinux [pkgs.autoPatchelfHook];
    buildInputs = pkgs.lib.optionals pkgs.stdenv.hostPlatform.isLinux [pkgs.stdenv.cc.cc.lib];
    installPhase = ''
      install -Dm755 $src $out/libexec/clauth
      # the store is read-only, so disable clauth's self-updater
      makeWrapper $out/libexec/clauth $out/bin/clauth --set CLAUTH_NO_UPDATE 1
    '';
  };
in {
  home.packages = [clauth];

  programs.herdr = {
    enable = true;
    settings = {
      onboarding = false;
      # clauth herdr plugin: `herdr plugin install uwuclxdy/clauth/herdr-plugin`
      keys.command = [
        {
          key = "prefix+a";
          type = "plugin_action";
          command = "clauth.open";
          description = "clauth accounts";
        }
      ];
      ui.sidebar.agents.rows_by_agent = {
        claude = [["state_icon" "workspace" "tab"] ["terminal_title_stripped"] ["agent" "$clauth"]];
        codex = [["state_icon" "workspace" "tab"] ["terminal_title_stripped"] ["agent" "$clauth"]];
      };
    };
  };
}
