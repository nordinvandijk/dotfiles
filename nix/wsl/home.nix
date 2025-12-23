{
  pkgs,
  username,
  ...
}: let
  packages = with pkgs; [
    bat
    bottom
    coreutils
    curl
    du-dust
    fd
    findutils
    fx
    git
    htop
    killall
    mosh
    procs
    sd
    tree
    unzip
    vim
    wget
    zip
    azure-cli
    carapace
    chezmoi
    (
      with dotnetCorePackages;
      combinePackages [
        sdk_8_0
        sdk_9_0
      ]
    )
    gh
    lazygit
    neovim
    nushell
    ripgrep
    rustup
    starship

    # rust stuff
    cargo-cache
    cargo-expand

    # local dev stuf
    mkcert

    # treesitter
    tree-sitter

    # language servers
    nodePackages.vscode-langservers-extracted # html, css, json, eslint
    nodePackages.yaml-language-server
    nil # nix

    # formatters and linters
    alejandra # nix
    deadnix # nix
    nodePackages.prettier
    shellcheck
    shfmt
    statix # nix
  ];
in {
  home.stateVersion = "22.11";

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    sessionVariables.EDITOR = "nvim";
  };

  home.packages = packages;

  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      package = pkgs.git;
      delta.enable = true;
      delta.options = {
        line-numbers = true;
        side-by-side = true;
        navigate = true;
      };
      userEmail = ""; # FIXME: set your git email
      userName = ""; #FIXME: set your git username
      extraConfig = {
        push = {
          default = "current";
          autoSetupRemote = true;
        };
        merge = {
          conflictstyle = "diff3";
        };
        diff = {
          colorMoved = "default";
        };
      };
    };
  };
}
