#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

ensure_symlink() {
  local source_path="$1"
  local target_path="$2"
  local conflict_policy="$3"

  if [[ -L "$target_path" ]]; then
    local current
    current="$(readlink "$target_path")"
    if [[ "$current" == "$source_path" ]]; then
      info "Symlink already correct: $target_path"
      return 0
    fi
  fi

  if [[ -e "$target_path" || -L "$target_path" ]]; then
    case "$conflict_policy" in
      overwrite)
        info "Removing existing target for overwrite: $target_path"
        run_cmd rm -rf "$target_path"
        ;;
      skip-existing)
        warn "Skipping existing target: $target_path"
        return 0
        ;;
      interactive)
        read -r -p "Replace existing $target_path? [y/N] " answer
        if [[ ! "$answer" =~ ^[Yy]$ ]]; then
          warn "Skipping existing target: $target_path"
          return 0
        fi
        run_cmd rm -rf "$target_path"
        ;;
      *)
        die "Unknown conflict policy: $conflict_policy"
        ;;
    esac
  fi

  ensure_dir "$(dirname "$target_path")"
  run_cmd ln -s "$source_path" "$target_path"
  info "Linked $target_path -> $source_path"
}
