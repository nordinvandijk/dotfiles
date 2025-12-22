{
  description = "MacOs configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, ... }: {
      system.primaryUser = "nordin";
      nixpkgs.config.allowUnfree = true;

      environment.systemPackages =
        [
          pkgs.azure-cli
          pkgs.carapace
          pkgs.chezmoi
          pkgs.discord
          pkgs.docker
          (
            with pkgs.dotnetCorePackages;
            combinePackages [
              sdk_8_0
              sdk_9_0
            ]
          )
          pkgs.gh
          pkgs.lazygit
          pkgs.neovim
          pkgs.nodejs_24
          pkgs.nushell
          pkgs.obsidian
          pkgs.ripgrep
          pkgs.rustup
          pkgs.starship
          pkgs.wezterm
        ];

      homebrew = {
        enable = true;
        casks = [
          "google-chrome"
          "spotify"
        ];
        onActivation.cleanup = "zap";
      };

      fonts.packages = [
        pkgs.nerd-fonts.jetbrains-mono
      ];


      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."simple" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration 
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "nordin";
            autoMigrate = true;
          };
        }
      ];
    };
  };
}
