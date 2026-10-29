{pkgs, config, ...}: {
  programs.git = {
    enable = true;
    signing = {
      format = "ssh";
      key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
    settings = {
      user = {
        name = "Nordin van Dijk";
        email = "nordinvandijk@icloud.com";
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
      };
      push = {
        autoSetupRemote = true;
      };
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      color = {
        ui = "auto";
      };
      gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/.config/git/allowed_signers";
    };

    ignores = [
      "**/.claude/settings.local.json"
      ".DS_Store"
      "*.swp"
      "*.swo"
      "*~"
      ".idea/"
      ".vscode/"
      "node_modules/"
      ".env"
      ".env.local"
    ];
  };

  home.activation.gitAllowedSigners = config.lib.dag.entryAfter ["writeBoundary"] ''
    if [ -f "$HOME/.ssh/id_ed25519.pub" ]; then
      mkdir -p "$HOME/.config/git"
      echo "${config.programs.git.settings.user.email} $(cut -d' ' -f1-2 "$HOME/.ssh/id_ed25519.pub")" > "$HOME/.config/git/allowed_signers"
    fi
  '';
}
