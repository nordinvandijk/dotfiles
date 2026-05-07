{
  description = "nordinvandijk dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";

    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/3";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, determinate, nix-darwin, nixos-wsl, home-manager, nixvim, ... }:
  let
    homeModules = ./nix/home;
  in
  {
    darwinConfigurations.macos = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs self; };
      modules = [
        determinate.darwinModules.default
        ./nix/macos/configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nordin = {
            imports = [
              nixvim.homeModules.nixvim
              "${homeModules}/git.nix"
              "${homeModules}/nushell.nix"
              "${homeModules}/starship.nix"
              "${homeModules}/carapace.nix"
              "${homeModules}/gh.nix"
              "${homeModules}/nvim.nix"
              "${homeModules}/lazygit.nix"
              "${homeModules}/claude.nix"
            ];
            home.homeDirectory = "/Users/nordin";
            home.stateVersion = "24.11";
          };
        }
        {
          nix.enable = false;
          determinateNix.enable = true;
        }
      ];
    };

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs self;
        hostname = "nixos";
        username = "nordin";
      };
      modules = [
        nixos-wsl.nixosModules.wsl
        ./nix/wsl/wsl.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nordin = {
            imports = [
              nixvim.homeModules.nixvim
              "${homeModules}/git.nix"
              "${homeModules}/nushell.nix"
              "${homeModules}/nushell-wsl.nix"
              "${homeModules}/starship.nix"
              "${homeModules}/carapace.nix"
              "${homeModules}/gh.nix"
              "${homeModules}/nvim.nix"
              "${homeModules}/lazygit.nix"
              "${homeModules}/wezterm.nix"
            ];
            home.stateVersion = "24.11";
          };
        }
      ];
    };
  } // flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      devShells.default = pkgs.mkShell {
        packages = [ pkgs.claude-code ];
        shellHook = ''
          echo "Welcome to the dev environment!"
        '';
      };

      formatter = pkgs.alejandra;
    });
}
