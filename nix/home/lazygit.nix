{pkgs, ...}: {
  programs.lazygit = {
    enable = true;
    enableNushellIntegration = true;
    settings = {
      os = {
        openLink = "xdg-open {{link}}";
      };
      notARepository = "quit";
      customCommands = [
        {
          key = "W";
          description = "Add worktree in ../";
          command = ''git worktree add ../{{index .PromptResponses 0}} {{index .PromptResponses 0}}'';
          context = "localBranches";
          prompts = [
            {
              type = "input";
              title = "Branch / folder name (created under ../)";
            }
          ];
          loadingText = "Creating worktree...";
        }
      ];
    };
  };
}
