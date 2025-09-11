# dotfiles

My configuration dotfiles

## Installation

### Applications

For macos

```sh 
brew bundle install
```

For windows

```sh
winget import Winget.json
```

### Configurations

```sh
chezmoi init --apply https://github.com/nordinvandijk/dotfiles.git
```

## Application Overview

|             | macOs      | Windows  |
|-------------|------------|----------|
| Terminal    | Wezterm    | Wezterm  |
| Shell       | Nushell    | Nushell  |
| Prompt      | Starship   | Starship |
| Code Editor | Neovim     | Neovim   |
| Git Editor  | Lazygit    | Lazygit  |
| Containers  | OrbStack   | Docker   |
