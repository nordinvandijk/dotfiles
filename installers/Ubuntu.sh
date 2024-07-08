sudo apt-get install build-essential procps curl file git -y
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/nordinvandijk/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew tap Homebrew/bundle
brew bundle
stow -d ~/Documents/GitHub/dotfiles -t ~/ .
