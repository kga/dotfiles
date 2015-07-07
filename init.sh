#!/bin/sh

set -eux

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap Homebrew/brewdler
curl -O https://raw.githubusercontent.com/kga/dotfiles/master/Brewfile
brew bundle
rm Brewfile

ln -s $(brew --prefix)/Library/Contributions/brew_zsh_completion.zsh $(brew --prefix)/share/zsh/site-functions/_brew
