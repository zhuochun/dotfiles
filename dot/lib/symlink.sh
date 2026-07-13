#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

should_replace_target() {
  local target_path="$1"
  local conflict_policy="$2"

  [[ -e "$target_path" || -L "$target_path" ]] || return 0

  case "$conflict_policy" in
    overwrite)
      return 0
      ;;
    skip-existing)
      warn "Skipping existing target: $target_path"
      return 1
      ;;
    interactive)
      read -r -p "Replace existing $target_path? [y/N] " answer
      if [[ "$answer" =~ ^[Yy]$ ]]; then
        return 0
      fi
      warn "Skipping existing target: $target_path"
      return 1
      ;;
    *)
      die "Unknown conflict policy: $conflict_policy"
      ;;
  esac
}

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

  if ! should_replace_target "$target_path" "$conflict_policy"; then
    return 0
  fi

  if [[ -e "$target_path" || -L "$target_path" ]]; then
    info "Removing existing target for overwrite: $target_path"
    run_cmd rm -rf "$target_path" || return
  fi

  ensure_dir "$(dirname "$target_path")" || return
  run_cmd ln -s "$source_path" "$target_path" || return
  info "Linked $target_path -> $source_path"
}
