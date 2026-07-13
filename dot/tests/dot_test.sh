#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
TMP_ROOT="$(mktemp -d)"
trap 'rm -rf "$TMP_ROOT"' EXIT

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

assert_equals() {
  local expected="$1"
  local actual="$2"
  local message="$3"
  [[ "$actual" == "$expected" ]] || fail "$message (expected '$expected', got '$actual')"
}

assert_file_contains() {
  local expected="$1"
  local path="$2"
  local message="$3"
  [[ -f "$path" ]] || fail "$message (missing $path)"
  grep -Fqx "$expected" "$path" || fail "$message"
}

assert_not_exists() {
  local path="$1"
  local message="$2"
  [[ ! -e "$path" && ! -L "$path" ]] || fail "$message"
}

new_fixture() {
  local name="$1"
  CASE_ROOT="$TMP_ROOT/$name"
  REPO="$CASE_ROOT/repo"
  TEST_HOME="$CASE_ROOT/home"
  TEST_BIN="$CASE_ROOT/bin"

  mkdir -p "$REPO" "$TEST_HOME" "$TEST_BIN" "$REPO/.git"
  cp -R "$ROOT/dot" "$REPO/dot"
  cp -R "$ROOT/vim" "$REPO/vim"
  cp -R "$ROOT/espanso" "$REPO/espanso"
  cp -R "$ROOT/rime" "$REPO/rime"
  cp -R "$ROOT/mac" "$REPO/mac"
  mkdir -p "$REPO/scripts"
  cp "$ROOT/zshrc" "$ROOT/zshenv" "$ROOT/tmux.conf" "$ROOT/tmux-theme.conf" "$REPO/"

  cat >"$TEST_BIN/uname" <<'SH'
#!/usr/bin/env bash
printf 'Darwin\n'
SH
  cat >"$TEST_BIN/brew" <<'SH'
#!/usr/bin/env bash
exit 0
SH
  chmod +x "$TEST_BIN/uname" "$TEST_BIN/brew"
}

run_dot() {
  HOME="$TEST_HOME" PATH="$TEST_BIN:/usr/bin:/bin" bash "$REPO/dot/dot" "$@"
}

run_without_rsync() {
  local script="$1"
  shift

  local bash_bin
  bash_bin="$(command -v bash)"
  local isolated_bin="$CASE_ROOT/no-rsync-bin"
  mkdir -p "$isolated_bin"
  for command in cat date dirname mkdir; do
    ln -s "$(command -v "$command")" "$isolated_bin/$command"
  done
  ln -s "$bash_bin" "$isolated_bin/bash"
  ln -s "$TEST_BIN/uname" "$isolated_bin/uname"

  HOME="$TEST_HOME" PATH="$isolated_bin" "$bash_bin" "$script" "$@"
}

snapshot_home() {
  local shasum_bin
  if shasum_bin="$(command -v shasum)"; then
    :
  elif [[ -x /usr/bin/shasum ]]; then
    shasum_bin=/usr/bin/shasum
  elif [[ -x /usr/bin/core_perl/shasum ]]; then
    shasum_bin=/usr/bin/core_perl/shasum
  else
    fail 'shasum is required to snapshot the fixture home'
  fi

  (
    cd "$TEST_HOME"
    find . -type d -print
    find . -type f -exec "$shasum_bin" -a 256 {} +
    find . -type l -exec sh -c \
      'for path do printf "%s -> %s\n" "$path" "$(readlink "$path")"; done' sh {} +
  ) | sort
}

prepare_existing_setup_targets() {
  mkdir -p \
    "$TEST_HOME/.config/nvim/rc" \
    "$TEST_HOME/.vim/rc" \
    "$TEST_HOME/Library/Application Support/espanso/match" \
    "$TEST_HOME/Library/Rime" \
    "$TEST_HOME/.config/karabiner/assets/complex_modifications"

  printf 'user zshrc\n' >"$TEST_HOME/.zshrc"
  printf 'user zshenv\n' >"$TEST_HOME/.zshenv"
  printf 'user tmux\n' >"$TEST_HOME/.tmux.conf"
  printf 'user tmux theme\n' >"$TEST_HOME/.tmux-theme.conf"
  printf 'user nvim\n' >"$TEST_HOME/.config/nvim/init.vim"
  printf 'user vimrc\n' >"$TEST_HOME/.vimrc"
  printf 'user gvimrc\n' >"$TEST_HOME/.gvimrc"
  printf 'user espanso base\n' >"$TEST_HOME/Library/Application Support/espanso/match/base.yml"
  printf 'user espanso form\n' >"$TEST_HOME/Library/Application Support/espanso/match/form.yml"
  printf 'user rime\n' >"$TEST_HOME/Library/Rime/squirrel.custom.yaml"
  printf 'user karabiner\n' >"$TEST_HOME/.config/karabiner/karabiner.json"
}

install_backup_fakes() {
  cat >"$TEST_BIN/brew" <<'SH'
#!/usr/bin/env bash
for arg in "$@"; do
  case "$arg" in
    --file=*) output="${arg#--file=}" ;;
  esac
done
mkdir -p "$(dirname "$output")"
printf 'brew "fixture"\n' >"$output"
SH

  chmod +x "$TEST_BIN/brew"
}

test_setup_preserves_existing_config_by_default() {
  new_fixture setup-preserves-existing
  prepare_existing_setup_targets

  run_dot setup >/dev/null 2>&1

  assert_equals 'user zshrc' "$(<"$TEST_HOME/.zshrc")" \
    'setup replaced an existing symlink target by default'
  assert_equals 'user karabiner' "$(<"$TEST_HOME/.config/karabiner/karabiner.json")" \
    'setup replaced an existing copy target by default'
}

test_setup_secures_private_config_files() {
  new_fixture setup-secures-private-files
  prepare_existing_setup_targets
  CHMOD_LOG="$CASE_ROOT/chmod.log"
  export CHMOD_LOG
  cat >"$TEST_BIN/chmod" <<'SH'
#!/usr/bin/env bash
printf '%s\n' "$*" >>"$CHMOD_LOG"
SH
  chmod +x "$TEST_BIN/chmod"

  run_dot setup >/dev/null 2>&1

  assert_file_contains "600 $TEST_HOME/.localrc" "$CHMOD_LOG" \
    'setup did not secure .localrc with mode 600'
  assert_file_contains "600 $TEST_HOME/.localenv" "$CHMOD_LOG" \
    'setup did not secure .localenv with mode 600'
}

test_setup_does_not_require_unrelated_tools() {
  new_fixture setup-native-tools-only
  prepare_existing_setup_targets
  rm "$TEST_BIN/brew"

  if ! run_dot setup >/dev/null 2>&1; then
    fail 'setup required Homebrew, Git, or rsync even though it uses none of them'
  fi
}

test_setup_is_idempotent() {
  new_fixture setup-idempotent

  run_dot setup >/dev/null 2>&1
  first_tree="$(snapshot_home)"
  run_dot setup >/dev/null 2>&1
  second_tree="$(snapshot_home)"

  assert_equals "$first_tree" "$second_tree" \
    'running setup twice changed the installed home configuration'
}

test_setup_records_hard_failures() {
  new_fixture setup-failure
  rm "$REPO/dot/manifests/setup.macos.tsv"

  if run_dot setup >/dev/null 2>&1; then
    fail 'setup returned success after a manifest failure'
  fi

  assert_file_contains '  "status": "failed",' "$REPO/.state/last-run.json" \
    'setup failure left a missing or stale success run log'
}

test_setup_records_unreadable_manifest_failures() {
  new_fixture setup-unreadable-manifest
  chmod 000 "$REPO/dot/manifests/setup.macos.tsv"

  if [[ -r "$REPO/dot/manifests/setup.macos.tsv" ]]; then
    chmod 600 "$REPO/dot/manifests/setup.macos.tsv"
    return 0
  fi

  if run_dot setup >/dev/null 2>&1; then
    chmod 600 "$REPO/dot/manifests/setup.macos.tsv"
    fail 'setup returned success with an unreadable manifest'
  fi
  chmod 600 "$REPO/dot/manifests/setup.macos.tsv"

  assert_file_contains '  "status": "failed",' "$REPO/.state/last-run.json" \
    'unreadable manifest left a missing or stale success run log'
}

test_setup_records_unsupported_platform_failures() {
  new_fixture setup-unsupported-platform
  cat >"$TEST_BIN/uname" <<'SH'
#!/usr/bin/env bash
printf 'Linux\n'
SH

  if run_dot setup >/dev/null 2>&1; then
    fail 'setup ran on an unsupported platform'
  fi

  assert_file_contains '  "status": "failed",' "$REPO/.state/last-run.json" \
    'unsupported-platform failure left a missing or stale success run log'
}

test_restore_preflights_rsync_before_writes() {
  new_fixture restore-rsync-preflight

  if run_without_rsync "$REPO/dot/dot" restore --apply >/dev/null 2>&1; then
    fail 'restore ran without its required rsync dependency'
  fi

  assert_file_contains '  "status": "failed",' "$REPO/.state/last-run.json" \
    'restore preflight failure left a missing or stale success run log'
  assert_not_exists "$TEST_HOME/Library/Application Support/espanso" \
    'restore created a destination before checking rsync'
}

test_restore_default_dry_run_does_not_write_failure_log() {
  new_fixture restore-default-dry-run

  if run_without_rsync "$REPO/dot/dot" restore >/dev/null 2>&1; then
    fail 'restore ran without its required rsync dependency'
  fi

  assert_not_exists "$REPO/.state" \
    'default restore dry-run wrote a failure log'
  assert_not_exists "$TEST_HOME/Library/Application Support/espanso" \
    'default restore dry-run created a destination'
}

test_restore_stops_when_snapshot_fails() {
  new_fixture restore-snapshot-failure
  local rectangle_dir="$TEST_HOME/Library/Application Support/com.knollsoft.Rectangle"
  local rectangle_config="$rectangle_dir/RectangleConfig.json"
  mkdir -p "$rectangle_dir"
  printf 'user rectangle\n' >"$rectangle_config"

  cat >"$TEST_BIN/rsync" <<'SH'
#!/usr/bin/env bash
exit 0
SH
  cat >"$TEST_BIN/cp" <<'SH'
#!/usr/bin/env bash
for arg in "$@"; do
  case "$arg" in
    *'.dotfiles-restore-backups'*) exit 23 ;;
  esac
done
exec /bin/cp "$@"
SH
  chmod +x "$TEST_BIN/rsync" "$TEST_BIN/cp"

  if run_dot restore --apply >/dev/null 2>&1; then
    fail 'restore returned success after a snapshot failure'
  fi

  assert_equals 'user rectangle' "$(<"$rectangle_config")" \
    'restore overwrote config after its rollback snapshot failed'
  assert_file_contains '  "status": "failed",' "$REPO/.state/last-run.json" \
    'snapshot failure did not produce a failed run log'
}

test_local_backup_preflights_rsync_before_writes() {
  new_fixture local-backup-rsync-preflight
  mkdir -p "$TEST_HOME/.ssh"
  printf 'private\n' >"$TEST_HOME/.localrc"
  printf 'environment\n' >"$TEST_HOME/.localenv"
  printf 'git config\n' >"$TEST_HOME/.gitconfig"

  if run_without_rsync "$REPO/dot/local" backup >/dev/null 2>&1; then
    fail 'local backup ran without its required rsync dependency'
  fi

  assert_not_exists "$TEST_HOME/localrc" \
    'local backup created a partial destination before checking rsync'
  assert_file_contains '  "status": "failed",' "$REPO/.state/last-run.json" \
    'local backup preflight failure left a missing or stale success run log'
}

test_local_restore_preflights_rsync_before_writes() {
  new_fixture local-restore-rsync-preflight
  local backup_dir="$CASE_ROOT/backup"
  mkdir -p "$backup_dir/ssh"
  printf 'private\n' >"$backup_dir/localrc"

  if run_without_rsync "$REPO/dot/local" restore --from "$backup_dir" --apply >/dev/null 2>&1; then
    fail 'local restore ran without its required rsync dependency'
  fi

  assert_not_exists "$TEST_HOME/.localrc" \
    'local restore wrote config before checking rsync'
  assert_not_exists "$TEST_HOME/.dotfiles-restore-backups" \
    'local restore created a rollback directory before checking rsync'
  assert_file_contains '  "status": "failed",' "$REPO/.state/last-run.json" \
    'local restore preflight failure left a missing or stale success run log'
}

test_backup_only_captures_copied_resources() {
  new_fixture backup-copies-only
  install_backup_fakes
  original_rime="$(<"$REPO/rime/squirrel.custom.yaml")"

  mkdir -p \
    "$TEST_HOME/.config/karabiner/assets/complex_modifications" \
    "$TEST_HOME/Library/Application Support/espanso/match" \
    "$TEST_HOME/Library/Rime" \
    "$TEST_HOME/Library/Application Support/com.knollsoft.Rectangle"
  printf 'home karabiner\n' >"$TEST_HOME/.config/karabiner/karabiner.json"
  printf 'home rule\n' >"$TEST_HOME/.config/karabiner/assets/complex_modifications/home-rule.json"
  printf 'home espanso\n' >"$TEST_HOME/Library/Application Support/espanso/match/secret.yml"
  printf 'home rime\n' >"$TEST_HOME/Library/Rime/squirrel.custom.yaml"
  printf 'home rectangle\n' >"$TEST_HOME/Library/Application Support/com.knollsoft.Rectangle/RectangleConfig.json"

  run_dot backup >/dev/null

  assert_equals 'home karabiner' "$(<"$REPO/mac/karabiner.json")" \
    'backup did not capture the copied Karabiner config'
  assert_equals 'home rectangle' "$(<"$REPO/mac/RectangleConfig.json")" \
    'backup did not capture the copied Rectangle config'
  assert_equals "$original_rime" "$(<"$REPO/rime/squirrel.custom.yaml")" \
    'backup modified a setup-managed Rime source'
  assert_not_exists "$REPO/espanso/match/secret.yml" \
    'backup copied untracked Espanso state into the repository'
  assert_not_exists "$REPO/mac/karabiner-rules/home-rule.json" \
    'backup copied setup-managed Karabiner rules into the repository'
}

test_backup_records_skipped_sources_as_partial() {
  new_fixture backup-partial
  install_backup_fakes
  mkdir -p "$TEST_HOME/.config/karabiner"
  printf 'home karabiner\n' >"$TEST_HOME/.config/karabiner/karabiner.json"

  run_dot backup >/dev/null 2>&1

  assert_file_contains '  "status": "partial",' "$REPO/.state/last-run.json" \
    'backup reported ok after skipping an app source'
  assert_file_contains '  "details": "manifest=backup.macos.tsv,skipped=1"' "$REPO/.state/last-run.json" \
    'backup did not report its skipped-source count'
}

test_backup_records_hard_failures() {
  new_fixture backup-failure
  install_backup_fakes
  rm "$REPO/dot/manifests/backup.macos.tsv"
  mkdir -p \
    "$TEST_HOME/.config/karabiner" \
    "$TEST_HOME/Library/Application Support/com.knollsoft.Rectangle"
  printf 'home karabiner\n' >"$TEST_HOME/.config/karabiner/karabiner.json"
  printf 'home rectangle\n' >"$TEST_HOME/Library/Application Support/com.knollsoft.Rectangle/RectangleConfig.json"

  if run_dot backup >/dev/null 2>&1; then
    fail 'backup returned success after a manifest failure'
  fi

  assert_file_contains '  "status": "failed",' "$REPO/.state/last-run.json" \
    'backup failure left a missing or stale success run log'
}

test_backup_requires_homebrew() {
  new_fixture backup-requires-homebrew
  rm "$TEST_BIN/brew"

  if run_dot backup >/dev/null 2>&1; then
    fail 'backup ran without its non-native Homebrew dependency'
  fi

  assert_file_contains '  "status": "failed",' "$REPO/.state/last-run.json" \
    'missing Homebrew did not produce a failed run log'
}

test_setup_preserves_existing_config_by_default
test_setup_secures_private_config_files
test_setup_does_not_require_unrelated_tools
test_setup_is_idempotent
test_setup_records_hard_failures
test_setup_records_unreadable_manifest_failures
test_setup_records_unsupported_platform_failures
test_restore_preflights_rsync_before_writes
test_restore_default_dry_run_does_not_write_failure_log
test_restore_stops_when_snapshot_fails
test_local_backup_preflights_rsync_before_writes
test_local_restore_preflights_rsync_before_writes
test_backup_only_captures_copied_resources
test_backup_records_skipped_sources_as_partial
test_backup_records_hard_failures
test_backup_requires_homebrew
printf 'PASS: dot/dot CLI tests\n'
