{pkgs, ...}: {
  programs.lazygit = {
    enable = true;
    enableNushellIntegration = true;
    settings = {
      os = {
        openLink = "xdg-open {{link}}";
      };
    };
  };
}
