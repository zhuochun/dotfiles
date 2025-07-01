#!/usr/bin/env bash
set -euo pipefail

# Restore Espanso configs
mkdir -p "$HOME/Library/Application Support/espanso"
cp -R "$HOME/dotfiles/espanso"/* "$HOME/Library/Application Support/espanso/"

# Restore Rime configs
mkdir -p "$HOME/Library/Rime"
cp "$HOME/dotfiles/rime"/*.yaml "$HOME/Library/Rime/"

# Restore Rectangle configuration
mkdir -p "$HOME/Library/Application Support/com.knollsoft.Rectangle"
cp "$HOME/dotfiles/mac/RectangleConfig.json" \
  "$HOME/Library/Application Support/com.knollsoft.Rectangle/"

# Restore Karabiner rules
mkdir -p "$HOME/.config/karabiner/assets/complex_modifications"
cp "$HOME/dotfiles/mac/karabiner-rules"/*.json \
  "$HOME/.config/karabiner/assets/complex_modifications/"
