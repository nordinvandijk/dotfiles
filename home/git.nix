{pkgs, ...}: {
  programs.git = {
    enable = true;
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
}
