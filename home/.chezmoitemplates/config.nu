# config.nu
#
# Installed by:
# version = "0.105.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.


alias vim = nvim
$env.config.buffer_editor = "nvim"
$env.EDITOR = "nvim"

^ssh-agent -c
    | lines
    | first 2
    | parse "setenv {name} {value};"
    | transpose -r
    | into record
    | load-env

$env.config.shell_integration = {
  # osc2 abbreviates the path if in the home_dir, sets the tab/window title, shows the running command in the tab/window title
  osc2: true
  # osc7 is a way to communicate the path to the terminal, this is helpful for spawning new tabs in the same directory
  osc7: true
  # osc8 is also implemented as the deprecated setting ls.show_clickable_links, it shows clickable links in ls output if your terminal supports it
  osc8: true
  # osc9_9 is from ConEmu and is starting to get wider support. It's similar to osc7 in that it communicates the path to the terminal
  osc9_9: true
  # osc133 is several escapes invented by Final Term which include the supported ones below.
  # 133;A - Mark prompt start
  # 133;B - Mark prompt end
  # 133;C - Mark pre-execution
  # 133;D;exit - Mark execution finished with exit code
  # This is used to enable terminals to know where the prompt is, the command is, where the command finishes, and where the output of the command is
  osc133: false
  # osc633 is closely related to osc133 but only exists in visual studio code (vscode) and supports their shell integration features
  # 633;A - Mark prompt start
  # 633;B - Mark prompt end
  # 633;C - Mark pre-execution
  # 633;D;exit - Mark execution finished with exit code
  # 633;E - NOT IMPLEMENTED - Explicitly set the command line with an optional nonce
  # 633;P;Cwd=<path> - Mark the current working directory and communicate it to the terminal
  # and also helps with the run recent menu in vscode
  osc633: true
  # reset_application_mode is escape \x1b[?1l and was added to help ssh work better
  reset_application_mode: true
}
$env.config.show_banner = false

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
