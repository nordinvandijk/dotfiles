{pkgs, ...}: {
  programs.nushell = {
    enable = true;

    extraConfig = ''
      $env.config = {
        show_banner: false
      }
      $env.config.buffer_editor = "nvim"
      $env.EDITOR = "nvim"
    '';

    extraEnv = ''
    '';

    shellAliases = {
       v = "nvim .";
       vim = "nvim";
       nano = "hx";
       c = "clear";
       lg = "lazygit";
       cursor = "cursor-agent";
    };
  };
}
