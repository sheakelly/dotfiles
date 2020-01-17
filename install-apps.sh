#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# tap some casks
brew tap homebrew/cask-versions
brew tap homebrew/cask-fonts

# Install dev apps and tools
brew install git
brew install ruby
brew install tmux
brew install neovim
brew install zsh
brew install ripgrep
brew install fzf
brew install z
brew cask install font-hack-nerd-font
brew cask install iterm2
brew install node
brew install python3
brew install nvm
brew install pyenv

npm install -g neovim
npm install -g spaceship-prompt
npm i -g bash-language-server
npm install -g vtop
pip3 install saws # super charged aws cli
pip3 install neovim

# Install other apps
brew cask install google-chrome
brew cask install google-chrome-canary
brew cask install spotify
brew cask install slack
brew cask install mtmr
brew install p7zip

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

# Install vim plugins
nvim +PlugInstall +qall
nvim +UpdateRemotePlugins +qall

# Install vim airline theme
cp ~/.config/nvim/space.vim ~/.config/nvim/plugged/vim-airline-themes/autoload/airline/themes/space.vim

# Install tmux plugin manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/scripts/install_plugins.sh
fi
