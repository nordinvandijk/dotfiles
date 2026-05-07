# dotfiles

My configuration dotfiles

## Installation

### Configurations

Install Nix or NixOS

```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

```
https://nix-community.github.io/NixOS-WSL/install.html
```

Install git via nix so that you can clone the dotfiles repo

```
nix-env -iA nixos.git
```

Clone the repo

```sh
git clone https://github.com/nordin/dotfiles.git
```

Install the nix flake

*MacOS*

```
sudo darwin-rebuild switch --flake ./dotfiles#macos
```

*WSL*

```
sudo nixos-rebuild switch --flake ./dotfiles#nixos
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
