{
  config,
  inputs,
  pkgs,
  ...
}: {
  sops = {
    defaultSopsFile = "${inputs.self}/secrets/claude.yaml";
    secrets."playwright/mijnibis_email" = {};
    secrets."playwright/mijnibis_password" = {};
    templates."playwright-mcp.env".content = ''
      MIJNIBIS_EMAIL=${config.sops.placeholder."playwright/mijnibis_email"}
      MIJNIBIS_PASSWORD=${config.sops.placeholder."playwright/mijnibis_password"}
    '';
  };

  programs.claude-code = {
    mcpServers.playwright = {
      command = "${pkgs.playwright-mcp}/bin/playwright-mcp";
      args = ["--headless" "--isolated" "--secrets" config.sops.templates."playwright-mcp.env".path];
    };
    enable = true;
    context = ''
      - Create git worktrees in `~/.herdr/worktrees/<repo>/<branch>`, never inside the repository.
    '';
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
          jq=${pkgs.jq}/bin/jq
          # ~/.claude.json doesn't always carry oauthAccount, so ask the CLI for the real auth state
          email=$($jq -r '.oauthAccount.emailAddress // empty' "''${CLAUDE_CONFIG_DIR:-$HOME}/.claude.json" 2>/dev/null)
          if [ -n "$email" ]; then
            echo "$email"
            exit 0
          fi
          status=$(claude auth status --json 2>/dev/null | $jq -r '
            if .loggedIn then (.email // "logged in (\(.subscriptionType // .authMethod))")
            else "not logged in" end
          ' 2>/dev/null)
          echo "''${status:-auth unknown}"
        '');
      };
    };
  };
}
