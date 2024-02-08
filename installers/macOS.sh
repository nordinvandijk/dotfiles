brew tap Homebrew/bundle
brew bundle
gh repo clone nordinvandijk/dotfiles ~/documents/github/dotfiles
stow -d ~/documents/github/dotfiles -t ~/ .
