#!/bin/sh

set -e

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap Homebrew/brewdler
brew brewdle Brefile
