#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# tap some casks
brew tap caskroom/cask
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
# nvm and node
# pyenv and python

# Install other apps
brew cask install google-chrome
brew cask install google-chrome-canary
brew cask install todoist
brew cask install spotify
brew cask install slack
brew install p7zip

