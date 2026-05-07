{
  description = "WSL configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    home-modules = { url = "path:../home"; flake = false; };
  };

  outputs = inputs:
    with inputs; let
      nixpkgsWithOverlays = system: (import nixpkgs {
        inherit system;

        config = {
          allowUnfree = true;
          permittedInsecurePackages = [];
        };
      });

      configurationDefaults = args: {
      };

      argDefaults = {
        inherit secrets inputs self;
      };

      mkNixosConfiguration = {
        system ? "x86_64-linux",
        hostname,
        username,
        args ? {},
        modules,
      }: let
        specialArgs = argDefaults // {inherit hostname username;} // args;
      in
        nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          pkgs = nixpkgsWithOverlays system;
          modules = modules;
        };
    in {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

      nixosConfigurations.nixos = mkNixosConfiguration {
        hostname = "nixos";
        username = "nordin";
        modules = [
          nixos-wsl.nixosModules.wsl
          ./wsl.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nordin = {
              imports = [
                nixvim.homeModules.nixvim
                "${home-modules}/git.nix"
                "${home-modules}/nushell.nix"
                "${home-modules}/nushell-wsl.nix"
                "${home-modules}/starship.nix"
                "${home-modules}/carapace.nix"
                "${home-modules}/gh.nix"
                "${home-modules}/nvim.nix"
                "${home-modules}/lazygit.nix"
                "${home-modules}/wezterm.nix"
              ];
              home.stateVersion = "24.11";
            };
          }
        ];
      };
    };
}
