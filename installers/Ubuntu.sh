sudo apt-get update
sudo apt-get install build-essential procps curl file git -y
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> ~/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew tap Homebrew/bundle
brew bundle
stow -d ~/Documents/GitHub/dotfiles -t ~/ .

echo $(which zsh) | sudo tee -a /etc/shells
sudo chsh -s $(which zsh) $USER

zsh
