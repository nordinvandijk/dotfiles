{
  config,
  pkgs,
  ...
}: let
  keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
in {
  home.packages = [pkgs.sops];
  home.sessionVariables.SOPS_AGE_KEY_FILE = keyFile;
  programs.nushell.environmentVariables.SOPS_AGE_KEY_FILE = keyFile;

  sops.age.keyFile = keyFile;
}
