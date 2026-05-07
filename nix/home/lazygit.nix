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
          description = "Add worktree in ../ named after branch";
          command = ''git worktree add ../{{.SelectedLocalBranch.Name}} {{.SelectedLocalBranch.Name}}'';
          context = "localBranches";
          loadingText = "Creating worktree...";
        }
      ];
    };
  };
}
