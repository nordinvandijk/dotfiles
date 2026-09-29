{pkgs, ...}: {
  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
    nix-direnv.enable = true;
    config = {
      global.hide_env_diff = true;
      # worktrees are created by agents; trust them without `direnv allow` each time
      whitelist.prefix = ["~/.herdr/worktrees"];
    };
  };
}
