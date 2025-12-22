'''
wsl -d NixOS
'''

'''
nix-env -iA nixos.git
'''

'''
git clone https://github.com/nordinvandijk/dotfiles

'''
sudo nixos-rebuild switch --flake /tmp/configuration
'''

'''
chezmoi apply https://github.com/nordinvandijk/dotfiles
'''

