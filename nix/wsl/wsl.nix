{
  username,
  hostname,
  pkgs,
  inputs,
  ...
}: {
  time.timeZone = "Europe/Amsterdam";

  networking.hostName = "${hostname}";

  programs.bash.interactiveShellInit = ''
    if ! [ "$TERM" = "dumb" ] && [ -z "$BASH_EXECUTION_STRING" ]; then
      exec nu
    fi
  '';

  programs.nix-ld.enable = true;

  environment.enableAllTerminfo = true;
  environment.systemPackages = with pkgs; [
    acli
    act
    azure-cli
    bicep
    carapace
    chezmoi
    cursor-cli
    (
      with dotnetCorePackages;
      combinePackages [
        sdk_8_0
        sdk_9_0
        sdk_10_0
      ]
    )
    gh
    git
    github-copilot-cli
    icu
    kubectl
    lazygit
    neovim
    nodejs_24
    nushell
    pnpm
    powershell
    ripgrep
    roslyn
    roslyn-ls
    # rustup
    starship
    terraform
    unzip
    wslu
  ];
  environment.variables = {
    DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_10_0}/share/dotnet";
    EDITOR = "nvim";
  };

  security.sudo.wheelNeedsPassword = false;

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
    ];
  };

  system.stateVersion = "22.05";

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
    wslConf.network.generateHosts = false;
    defaultUser = username;
    startMenuLaunchers = true;
    docker-desktop.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };

  nix = {
    settings = {
      trusted-users = [username];

      accept-flake-config = true;
      auto-optimise-store = true;
    };

    registry = {
      nixpkgs = {
        flake = inputs.nixpkgs;
      };
    };

    nixPath = [
      "nixpkgs=${inputs.nixpkgs.outPath}"
      "nixos-config=/etc/nixos/configuration.nix"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];

    package = pkgs.nixVersions.stable;
    extraOptions = ''experimental-features = nix-command flakes'';

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };
}
