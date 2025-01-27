# Install packages to set up homebrew
sudo apt-get update
sudo apt-get install build-essential procps curl file -y

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> ~/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Install packages from Homebrew
brew tap Homebrew/bundle
brew bundle

# Symlink the config files to the home directory
stow -d . -t ~/ .

# Set zsh as default shell for the current user
echo $(which zsh) | sudo tee -a /etc/shells
chsh -s $(which zsh) $USER

# Start the zsh shell
zsh
