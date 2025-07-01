#!/usr/bin/env bash
set -euo pipefail

BACKUP_DIR="localrc"
SSH_DIR="$BACKUP_DIR/ssh"

# Create directories
mkdir -p "$SSH_DIR"

# Backup SSH, excluding authorized keys
rsync -av --exclude 'authorized*' "$HOME/.ssh/" "$SSH_DIR/"

# Backup local configs
rsync -av "$HOME/.localrc" "$BACKUP_DIR/localrc"
rsync -av "$HOME/.localenv" "$BACKUP_DIR/localenv"

# Backup gitconfig
rsync -av "$HOME/.gitconfig" "$BACKUP_DIR/gitconfig"
