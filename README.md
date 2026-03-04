# dotfiles

My configuration dotfiles

## Installation

### Applications

For windows

```sh
winget import Winget.json
```

### Configurations

Install NIX

```sh 
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

```
nix-env -iA nixos.git
```

```sh
git clone https://github.com/nordin/dotfiles.git 
```

```sh
cd dotfiles 
```

```
sudo nixos-rebuild switch --flake ./nix/wsl
```

## Application Overview

| Type        | Solution   |
|-------------|------------|
| Terminal    | Wezterm    |
| Shell       | Nushell    |
| Prompt      | Starship   |
| Code Editor | Neovim     |
| Git Editor  | Lazygit    | 
| Containers  | Docker     | 
