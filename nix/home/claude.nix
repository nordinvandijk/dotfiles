{pkgs, ...}: {
  programs.claude-code = {
    enable = true;
    skills = {
      herdr = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/herdrdev/herdr/v0.9.1/skills/herdr/SKILL.md";
        hash = "sha256-A4Vaeh+dCqG6ZET+0uSXGt95bpHnMAHY8kcvX55fZZ8=";
      };
    };
    settings = {
      model = "opus";
      statusLine = {
        type = "command";
        command = toString (pkgs.writeShellScript "claude-statusline" ''
          ${pkgs.jq}/bin/jq -r '.oauthAccount.emailAddress // "not logged in"' "''${CLAUDE_CONFIG_DIR:-$HOME}/.claude.json" 2>/dev/null
        '');
      };
    };
  };
}
