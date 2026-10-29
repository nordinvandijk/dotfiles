# WSL-only Nushell aliases (imported only from nix/wsl/flake.nix)
{pkgs, ...}: {
  programs.nushell.shellAliases = {
    dev = "nix develop ./.nix -c bash";
  };
}
