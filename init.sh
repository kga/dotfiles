#!/bin/sh

set -e

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap Homebrew/brewdler
curl -O https://raw.githubusercontent.com/kga/dotfiles/master/Brewfile
brew bundle
rm Brewfile
