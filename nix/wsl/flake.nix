{
  description = "WSL configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
    with inputs; let
      nixpkgsWithOverlays = system: (import nixpkgs {
        inherit system;

        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            # FIXME:: add any insecure packages you absolutely need here
          ];
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
        ];
      };
    };
}
