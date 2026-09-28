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
      hooks = {
        Stop = [
          {
            matcher = "";
            hooks = [
              {
                type = "command";
                command = "osascript -e 'display notification \"Claude has finished\" with title \"Claude Code\" sound name \"Glass\"'";
                timeout = 5;
              }
            ];
          }
        ];
      };
    };
  };
}
