{ self, pkgs, ... }: {
  system.primaryUser = "nordin";
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    btop
    discord
    colima
    docker
    gh
    google-chrome
    lazygit
    nushell
    obsidian
    ripgrep
    spotify
    starship
    wezterm
  ];

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  environment.interactiveShellInit = ''
    if ! [ "$TERM" = "dumb" ] && [ -z "$BASH_EXECUTION_STRING" ]; then
      exec nu
    fi
  '';

  launchd.user.agents.colima = {
    command = "${pkgs.colima}/bin/colima start --foreground";
    serviceConfig = {
      RunAtLoad = true;
      KeepAlive = false;
    };
  };

  system.defaults.dock.autohide = true;

  nix.settings.experimental-features = "nix-command flakes";

  system.configurationRevision = self.rev or self.dirtyRev or null;

  system.stateVersion = 6;

  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.nordin = {
    home = "/Users/nordin";
  };
}
