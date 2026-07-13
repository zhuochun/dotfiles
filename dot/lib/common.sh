#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

DRY_RUN=${DRY_RUN:-0}
VERBOSE=${VERBOSE:-0}

info() { printf '[INFO] %s\n' "$*"; }
warn() { printf '[WARN] %s\n' "$*" >&2; }
error() { printf '[ERROR] %s\n' "$*" >&2; }

die() {
  error "$*"
  exit 1
}

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

is_macos() {
  [[ "$(uname -s)" == "Darwin" ]]
}

ensure_dir() {
  local dir="$1"
  if [[ "$DRY_RUN" == "1" ]]; then
    info "DRY_RUN mkdir -p $dir"
    return 0
  fi
  mkdir -p "$dir"
}

ensure_private_file() {
  local path="$1"
  if [[ ! -e "$path" && ! -L "$path" ]]; then
    run_cmd touch "$path" || return
  fi
  run_cmd chmod 600 "$path"
}

run_cmd() {
  if [[ "$VERBOSE" == "1" || "$DRY_RUN" == "1" ]]; then
    info "run: $*"
  fi
  if [[ "$DRY_RUN" == "1" ]]; then
    return 0
  fi
  "$@"
}

require_repo_root() {
  local script_dir repo_root
  script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  repo_root="$(cd "$script_dir/../.." && pwd)"
  if [[ ! -d "$repo_root/.git" ]]; then
    die "Could not locate repository root from $script_dir"
  fi
  printf '%s\n' "$repo_root"
}

write_run_log() {
  local repo_root="$1"
  local command_name="$2"
  local status="$3"
  local details="$4"

  local state_dir="$repo_root/.state"
  ensure_dir "$state_dir"
  local log_file="$state_dir/last-run.json"

  if [[ "$DRY_RUN" == "1" ]]; then
    info "DRY_RUN write run log to $log_file"
    return 0
  fi

  cat >"$log_file" <<JSON
{
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "command": "$command_name",
  "status": "$status",
  "details": "$details"
}
JSON
}

copy_path() {
  local src="$1"
  local dest="$2"
  ensure_dir "$(dirname "$dest")"
  if [[ -d "$src" ]]; then
    run_cmd rsync -a "$src/" "$dest/"
  else
    run_cmd cp -f "$src" "$dest"
  fi
}

snapshot_path_if_exists() {
  local target="$1"
  local snapshot_root="$2"
  [[ -e "$target" || -L "$target" ]] || return 0

  local rel
  rel="${target#/}"
  local dest="$snapshot_root/$rel"
  ensure_dir "$(dirname "$dest")"
  if [[ -d "$target" && ! -L "$target" ]]; then
    run_cmd rsync -a "$target/" "$dest/"
  else
    run_cmd cp -a "$target" "$dest"
  fi
}

resolve_vars() {
  local value="$1"
  local repo_root="$2"
  value="${value//\{\{HOME\}\}/$HOME}"
  value="${value//\{\{REPO\}\}/$repo_root}"
  printf '%s\n' "$value"
}
