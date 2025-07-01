#!/usr/bin/env bash
set -euo pipefail

BACKUP_DIR="localrc"
SSH_DIR="$BACKUP_DIR/ssh"

# Ensure destination directories exist
mkdir -p "$HOME/.ssh"

# Restore SSH files
rsync -av "$SSH_DIR/" "$HOME/.ssh/"

# Restore local configs
rsync -av "$BACKUP_DIR/localrc" "$HOME/.localrc"
rsync -av "$BACKUP_DIR/localenv" "$HOME/.localenv"

# Restore gitconfig
rsync -av "$BACKUP_DIR/gitconfig" "$HOME/.gitconfig"
