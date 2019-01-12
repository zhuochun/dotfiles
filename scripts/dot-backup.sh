#!/usr/bin/env bash

# Backup Brewfile
brew bundle dump --force --file=~/dotfiles/scripts/Brewfile --describe

# Backup Karabiner
cp ~/.config/karabiner/karabiner.json ~/dotfiles/mac/karabiner.json
