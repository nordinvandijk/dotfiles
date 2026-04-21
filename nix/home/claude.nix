{pkgs, ...}: {
  programs.claude-code = {
    enable = true;
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
