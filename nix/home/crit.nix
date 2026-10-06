{pkgs, inputs, ...}: {
  home.packages = [inputs.crit.packages.${pkgs.stdenv.hostPlatform.system}.default];

  home.sessionVariables.CRIT_NO_INTEGRATION_CHECK = "1";
  programs.nushell.environmentVariables.CRIT_NO_INTEGRATION_CHECK = "1";

  programs.claude-code.plugins.crit = "${inputs.crit}/integrations/claude-code";
}
