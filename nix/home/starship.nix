{ lib, pkgs, ...}: {
  programs.starship = {
    enable = true;
    settings = {
        add_newline = false;
        format = lib.concatStrings [
            "$os"
            "$username"
            "$directory"
            "$git_branch"
            "$git_commit"
            "$git_state"
            "$git_status"
            "$cmd_duration"
            "$line_break"
            "$character"
        ];

        directory.style = "blue";

        git_branch.format = "[$symbol$branch(:$remote_branch)]($style) ";
        git_status.format = "([$ahead_behind]($style) )";
        git_status.style = "cyan";

        os.symbols = {
          Alpine = " ";
          Amazon = " ";
          Android = " ";
          Arch = " ";
          CentOS = " ";
          Debian = " ";
          DragonFly = " ";
          Fedora = " ";
          FreeBSD = " ";
          Kali = " ";
          Linux = " ";
          Macos = " ";
          NixOS = " ";
          Raspbian = " ";
          Ubuntu = " ";
          Windows = "󰍲 ";
        };

        os.format = "[$symbol ]($style)";
        os.style = "bold blue";
        os.disabled = false;
    };
  };
}
