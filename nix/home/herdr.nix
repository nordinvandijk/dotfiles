{pkgs, ...}: {
  programs.herdr = {
    enable = true;
    settings = {
      onboarding = false;
    };
  };
}
