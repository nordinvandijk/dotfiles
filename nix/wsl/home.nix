{
  pkgs,
  username,
  ...
}: let
  packages = with pkgs; [
    azure-cli
    carapace
    chezmoi
    cursor-cli
    (
      with dotnetCorePackages;
      combinePackages [
        sdk_8_0
        sdk_9_0
      ]
    )
    gh
    git
    lazygit
    neovim
    nodejs_24
    nushell
    powershell
    ripgrep
    roslyn
    roslyn-ls
    # rustup
    starship
  ];
in {
  home.stateVersion = "22.11";

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
  };

  programs = {
    home-manager.enable = true;
  };
}
