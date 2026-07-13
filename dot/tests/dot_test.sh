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
test_backup_only_captures_copied_resources
test_backup_records_skipped_sources_as_partial
test_backup_records_hard_failures
test_backup_requires_homebrew
printf 'PASS: dot/dot CLI tests\n'
