{
  description = "MacOs configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-modules = { url = "path:../home"; flake = false; };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager, home-modules }:
  let
    configuration = { pkgs, ... }: {
      system.primaryUser = "nordin";
      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = with pkgs;
        [
          azure-cli
          carapace
          chezmoi
          claude-code
          discord
          docker
          (
            with dotnetCorePackages;
            combinePackages [
              sdk_10_0
            ]
          )
          gh
          (haskellPackages.ghcWithPackages (pkgs: with pkgs; [ cabal-install ]))
          kubernetes-helm
          lazygit
          nodejs_24
          nushell
          obsidian
          pnpm
          ripgrep
          rustup
          starship
          wezterm
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

      environment.interactiveShellInit = ''
        if ! [ "$TERM" = "dumb" ] && [ -z "$BASH_EXECUTION_STRING" ]; then
          exec nu
        fi
      '';

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

      users.users.nordin = {
        home = "/Users/nordin";
      };
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
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nordin = { imports = [
            "${home-modules}/git.nix"
            "${home-modules}/nushell.nix"
            "${home-modules}/starship.nix"
            "${home-modules}/carapace.nix"
            "${home-modules}/gh.nix"
            "${home-modules}/nvim.nix"
          ]; home.homeDirectory = "/Users/nordin"; home.stateVersion = "24.11"; };
        }
      ];
    };
  };
}
