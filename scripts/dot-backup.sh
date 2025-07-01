#!/usr/bin/env bash
set -euo pipefail

# Backup Brewfile
mkdir -p "$HOME/dotfiles/scripts"
brew bundle dump --force --file="$HOME/dotfiles/scripts/Brewfile" --describe

# Backup Karabiner
mkdir -p "$HOME/dotfiles/mac"
cp "$HOME/.config/karabiner/karabiner.json" "$HOME/dotfiles/mac/karabiner.json"

# Backup Karabiner rules
mkdir -p "$HOME/dotfiles/mac/karabiner-rules"
cp "$HOME/.config/karabiner/assets/complex_modifications"/*.json \
  "$HOME/dotfiles/mac/karabiner-rules/"

# Backup Espanso configs
mkdir -p "$HOME/dotfiles/espanso"
cp -R "$HOME/Library/Application Support/espanso"/* "$HOME/dotfiles/espanso/"

# Backup Rime configs
mkdir -p "$HOME/dotfiles/rime"
cp "$HOME/Library/Rime"/*.yaml "$HOME/dotfiles/rime/"

# Backup Rectangle configuration
mkdir -p "$HOME/dotfiles/mac"
cp "$HOME/Library/Application Support/com.knollsoft.Rectangle"/*.json \
  "$HOME/dotfiles/mac/RectangleConfig.json"
