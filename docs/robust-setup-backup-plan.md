# Robust Dotfiles Setup / Backup / Restore Plan (macOS + separated localrc)

## Goals

- Make setup, backup, and restore reliable and repeatable on macOS.
- Keep repository-managed dotfiles separate from machine/company-specific secrets and overrides.
- Support a clear split between:
  - **dotfiles (tracked, shareable)**
  - **localrc (private, machine/company specific, not tracked in repo)**
- Be safe-by-default (no accidental overwrite of secrets), idempotent, and easy to audit.

---

## Current script gaps (from `scripts/dot-*` and `scripts/local-*`)

1. **No centralized configuration / path detection**
   - Scripts assume `~/dotfiles` and fixed paths.
   - No shared library for logging, dry-run, OS checks, or reusable helpers.

2. **Partial error handling**
   - `dot-setup.sh` lacks `set -euo pipefail`; others include it.
   - Some copy operations fail hard when source files are absent (fresh install case).

3. **Not idempotent enough for repeated runs**
   - `cp` can overwrite current user state without backup controls.
   - `grep ... >> ~/.zshrc` mutates a file that is also symlinked, which is brittle.

4. **No preflight validations**
   - Missing checks for required tools (`brew`, `rsync`, `git`) and app paths.
   - No check that commands are executed from the expected repo.

5. **Weak local/private split**
   - `local-backup.sh` currently writes into repo path by default.
   - No standardized timestamped backup policy under `$HOME`.

6. **Restore safety concerns**
   - `local-restore.sh` and `dot-restore.sh` may overwrite existing config without staged diff.
   - No automatic rollback snapshot before restore.

---

## Target architecture

### 1) Move orchestration under `dot/`

Consolidate setup/backup/restore logic under `dot/` (instead of `scripts/`) so command surface and implementation live together.

- `dot/lib/common.sh`
  - strict mode bootstrap
  - logging (`info`, `warn`, `error`)
  - `command_exists`, `ensure_dir`, `backup_existing`
  - platform detection (`is_macos`)
  - `DRY_RUN=1` support
- `dot/lib/symlink.sh`
  - declarative symlink creation with conflict reporting.

### 2) Declarative manifests under `dot/manifests/`

Define setup/backup/restore mappings in data files (TSV/YAML) rather than hardcoded copy lines.

- `dot/manifests/setup.macos.tsv`
  - source → target symlinks/copies
- `dot/manifests/backup.macos.tsv`
  - source → repo destination
- `dot/manifests/restore.macos.tsv`
  - repo source → home destination

This reduces drift and makes planned actions auditable.

### 3) New command surface (no legacy wrappers)

Use direct entrypoints and remove wrapper scripts.

- `dot/dot setup`
- `dot/dot backup`
- `dot/dot restore`
- `dot/local backup`
- `dot/local restore`

### 4) Localrc storage model (single stream + timestamped backups)

Use a single local backup stream with dated snapshots in `$HOME`:

- Runtime files remain:
  - `~/.localrc`
  - `~/.localenv`
  - optional `~/.localrc.company`
- Backup root:
  - `~/localrc/backup-YYYY-MM-DD/`
- Example backup content:
  - `~/localrc/backup-YYYY-MM-DD/localrc`
  - `~/localrc/backup-YYYY-MM-DD/localenv`
  - `~/localrc/backup-YYYY-MM-DD/gitconfig`
  - `~/localrc/backup-YYYY-MM-DD/ssh/` (excluding `authorized*`)

---

## Proposed directory layout

```text
dot/
  dot                  # CLI for setup/backup/restore of tracked dotfiles
  local                # CLI for local/private backup/restore
  lib/
    common.sh
    symlink.sh
  manifests/
    setup.macos.tsv
    backup.macos.tsv
    restore.macos.tsv
scripts/
  ...                  # deprecated during migration, then removed
$HOME/localrc/
  backup-YYYY-MM-DD/
```

---

## Restore/backup safety model

1. **Preflight**
   - Verify macOS for macOS-only resources.
   - Check required commands.
   - Validate source paths and read/write permissions.

2. **Dry-run by default for restore**
   - Print planned actions and counts.
   - Require `--apply` for writes.

3. **Automatic timestamp snapshot before restore**
   - e.g. `~/.dotfiles-restore-backups/2026-.../`
   - Snapshot only files scheduled to change.

4. **Conflict policy**
   - `--overwrite`, `--skip-existing`, `--interactive` modes.

5. **Audit output**
   - Machine-readable run log, e.g. `./.state/last-run.json`.

---

## macOS-specific recommendations

- Guard app-specific paths (Karabiner, Espanso, Rectangle, Rime) with existence checks.
- Add `defaults export/import` for macOS preferences where useful.
- Homebrew flow:
  - `brew bundle check` before install
  - `brew bundle install` only when needed
  - optional `brew bundle cleanup --force` in explicit maintenance mode only

---

## Local/company-specific workflow

Recommended load order:

1. `~/dotfiles/zshrc` (repo-managed)
2. `~/.localrc` (machine overrides)
3. `~/.localrc.company` (company-specific overrides, optional)

Backup and restore flow:

- `dot/local backup`
  - creates `~/localrc/backup-YYYY-MM-DD/`
  - captures `.localrc`, `.localenv`, `.gitconfig`, selected `.ssh` files
- `dot/local restore --from ~/localrc/backup-YYYY-MM-DD --dry-run`
- `dot/local restore --from ~/localrc/backup-YYYY-MM-DD --apply`

---

## Migration plan (incremental)

### Phase 1 — harden current scripts (low risk)

- Add strict mode + preflight checks across current scripts.
- Add guard clauses for absent source files/directories.
- Normalize rsync/cp behavior and return codes.
- Add `--dry-run` and `--verbose`.

### Phase 2 — introduce `dot/` structure

- Add `dot/lib/common.sh` and move shared logic.
- Add `dot/dot` and `dot/local` dispatchers.
- Transition callers from `scripts/*` to `dot/*`.

### Phase 3 — manifest-driven operations

- Move hardcoded operations to `dot/manifests/*`.
- Add conflict policy and run reports.

### Phase 4 — localrc timestamped backups

- Implement `~/localrc/backup-YYYY-MM-DD/` strategy.
- Support selecting restore source via `--from`.
- Add optional encryption for sensitive backup folders.

### Phase 5 — validation + CI

- Add shellcheck and shfmt checks.
- Add smoke tests (dry-run) for command paths and manifest parsing.

---

## Acceptance criteria

- Running setup twice is idempotent.
- Restore dry-run performs no writes.
- Restore makes rollback snapshot before writes.
- Local backups are written to `~/localrc/backup-YYYY-MM-DD/`.
- macOS-only resources are processed conditionally.
- Scripts return clear errors and non-zero exit codes on failure.

---

## Suggested first implementation slice

1. Create `dot/lib/common.sh`.
2. Refactor `dot-setup` flow to strict mode + shared helpers.
3. Add `--dry-run` to local restore path.
4. Implement `dot/local backup` creating `~/localrc/backup-YYYY-MM-DD/`.
5. Document the new `dot/*` command usage with examples.

This slice delivers immediate robustness while keeping migration incremental.
