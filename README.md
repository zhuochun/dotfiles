# Zhuochun's dotfiles

A set of macOS and Windows dotfiles, keyboard customizations, editor settings, and backup/restore helpers.

> **Current setup status:** the maintained setup flow is the manifest-driven `dot/` CLI. The older `scripts/*.sh` files are legacy helpers; do not use them as the primary setup path unless you are intentionally debugging old behavior.

<details>
  <summary><strong>Table of Contents</strong> (click to expand)</summary>

<!-- TOC depthFrom:2 -->

- [AI Agent Quick Start](#ai-agent-quick-start)
  - [Repository Rules for Agents](#repository-rules-for-agents)
  - [Fresh macOS Setup Checklist](#fresh-macos-setup-checklist)
  - [Validation Checklist](#validation-checklist)
- [Command Reference](#command-reference)
  - [`dot/dot`](#dotdot)
  - [`dot/local`](#dotlocal)
- [Mac Setup](#mac-setup)
  - [System Preferences](#system-preferences)
  - [Applications and CLI Tools](#applications-and-cli-tools)
  - [Shell](#shell)
  - [Tmux](#tmux)
  - [Keyboard Enhancements](#keyboard-enhancements)
- [Vim / Neovim](#vim--neovim)
- [Windows Setup](#windows-setup)
  - [AutoHotkey](#autohotkey)
- [Others](#others)
  - [Custom Scripts](#custom-scripts)
  - [Fonts](#fonts)
  - [Themes](#themes)
  - [Text Expander](#text-expander)
  - [Rime](#rime)
  - [Atom](#atom)

<!-- /TOC -->
</details>

## AI Agent Quick Start

Use this section as the source of truth when completing setup on behalf of a user.

### Repository Rules for Agents

- **Do not assume `~/dotfiles` exists.** Clone this repository there before running setup commands, or replace `~/dotfiles` in commands with the actual checkout path.
- **Do not run destructive restores without an explicit `--apply`.** `dot/dot restore` and `dot/local restore` intentionally default to dry-run mode unless `--apply` is supplied.
- **Do not put private secrets in this repository.** Machine/company/private files belong in `~/.localrc`, `~/.localenv`, `~/.gitconfig`, and `~/.ssh`, and can be backed up with `dot/local backup`.
- **Prefer the manifest-driven CLI.** The maintained entrypoints are `dot/dot` and `dot/local`; the old scripts in `scripts/` are not the primary setup flow.
- **macOS support is first-class.** `dot/dot setup`, `dot/dot backup`, and `dot/dot restore` currently enforce macOS via `uname -s == Darwin`.

### Fresh macOS Setup Checklist

1. Install Apple's command line tools if Git is not already available:

   ```bash
   xcode-select --install
   ```

2. Clone this repository:

   ```bash
   git clone git@github.com:zhuochun/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

3. Install Homebrew if `brew` is not available:

   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

4. Install the Homebrew bundle. `dot/dot setup` requires Homebrew, but it does **not** install the bundle for you:

   ```bash
   brew bundle check --file=~/dotfiles/scripts/Brewfile || brew bundle install --file=~/dotfiles/scripts/Brewfile
   ```

5. Preview dotfile setup actions:

   ```bash
   ~/dotfiles/dot/dot setup --dry-run --verbose
   ```

6. Apply tracked dotfile setup. The default conflict policy is `--overwrite`; use `--skip-existing` for a safer first pass on an existing machine:

   ```bash
   ~/dotfiles/dot/dot setup --skip-existing --verbose
   ```

7. Ensure Zsh is allowed and make it the default shell if needed:

   ```bash
   which zsh
   grep -Fx "$(which zsh)" /etc/shells || echo "$(which zsh)" | sudo tee -a /etc/shells
   chsh -s "$(which zsh)"
   ```

8. Install oh-my-zsh and custom plugins if they are missing:

   ```bash
   test -d ~/.oh-my-zsh || sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   test -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
   test -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions || git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
   ```

9. Install Tmux Plugin Manager if it is missing:

   ```bash
   test -d ~/.tmux/plugins/tpm || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```

10. Install Vim/Neovim plugins:

    ```bash
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Shougo/dein-installer.vim/master/installer.sh)"
    nvim +'call dein#install()' +qall
    ```

11. Open GUI apps that need permissions and complete their prompts:

    - Karabiner-Elements: grant keyboard/input monitoring permissions, then restart Karabiner.
    - Espanso: grant accessibility permissions.
    - Rectangle: import or verify its config if needed.
    - Rime/Squirrel: deploy the input method configuration if installed.

12. Create or restore private local config outside this repository:

    ```bash
    touch ~/.localrc ~/.localenv
    ~/dotfiles/dot/local backup --dry-run --verbose
    # To restore an existing private backup:
    # ~/dotfiles/dot/local restore --from ~/localrc/backup-YYYY-MM-DD --dry-run --verbose
    # ~/dotfiles/dot/local restore --from ~/localrc/backup-YYYY-MM-DD --apply --verbose
    ```

### Validation Checklist

Run these checks after setup:

```bash
brew bundle check --file=~/dotfiles/scripts/Brewfile
~/dotfiles/dot/dot setup --dry-run --verbose
zsh -n ~/dotfiles/zshrc ~/dotfiles/zshenv
bash -n ~/dotfiles/dot/dot ~/dotfiles/dot/local ~/dotfiles/dot/lib/common.sh ~/dotfiles/dot/lib/symlink.sh
nvim --headless +q
```

Expected results:

- `brew bundle check` exits successfully, or prints the packages still needing installation.
- `dot/dot setup --dry-run --verbose` lists planned actions without writing files.
- Shell syntax checks exit successfully.
- `nvim --headless +q` exits successfully after Neovim is installed.

## Command Reference

### `dot/dot`

`dot/dot` manages tracked dotfiles and app configuration on macOS.

```bash
~/dotfiles/dot/dot setup [--dry-run] [--overwrite|--skip-existing|--interactive] [--verbose]
~/dotfiles/dot/dot backup [--dry-run] [--verbose]
~/dotfiles/dot/dot restore [--dry-run] [--apply] [--verbose]
```

- `setup` reads `dot/manifests/setup.macos.tsv` and creates symlinks/copies into `$HOME`.
- `backup` updates `scripts/Brewfile` with `brew bundle dump` when Homebrew is available, then copies/syncs configured app files from `$HOME` into the repo using `dot/manifests/backup.macos.tsv`.
- `restore` copies/syncs tracked app files from the repo back into `$HOME` using `dot/manifests/restore.macos.tsv`; it is dry-run by default and requires `--apply` to write.
- Restore creates rollback snapshots under `~/.dotfiles-restore-backups/<timestamp>/` before overwriting existing paths.

### `dot/local`

`dot/local` manages private machine/company config that should not be committed.

```bash
~/dotfiles/dot/local backup [--dry-run] [--verbose]
~/dotfiles/dot/local restore --from <backup_dir> [--dry-run] [--apply] [--overwrite|--skip-existing] [--verbose]
```

- `backup` writes timestamped backups under `~/localrc/backup-YYYY-MM-DD/` or `~/localrc/backup-YYYY-MM-DD-HHMMSS/` if the daily directory already exists.
- Backup content includes `.localrc`, `.localenv`, `.gitconfig`, and `~/.ssh/` excluding `authorized*` files when present.
- `restore` is dry-run by default and requires `--apply` to write.
- Local restores also create rollback snapshots under `~/.dotfiles-restore-backups/<timestamp>/`.

## Mac Setup

### System Preferences

- Trackpad -> Enable `Tap to click`.
- Accessibility -> Pointer Control -> Trackpad Options -> Enable dragging `Three finger dragging`.
- Dock -> Position `Left`, Enable `Automatically hide and show` and `Minimise windows into application icon`, Disable `Show recent applications in Dock`.
- Keyboard -> Keyboard
  - Fastest Key Repeat, Shortest Delay, Enable `Standard function keys`.
  - Modifier Keys... -> Change `Caps Lock` to `Command` key.
- Keyboard -> Shortcuts -> Screen Shots
  - Disable "picture of screen" shortcuts.
  - Remap picture of selected area to `<M-s>` (File) and `<M-S>` (Clipboard).
- Keyboard -> Input Sources -> Add `Pinyin - Simplified`.

Other preferences:

```bash
# Disable "press and hold" option
defaults write -g ApplePressAndHoldEnabled -bool false
# Display all file extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
```

### Applications and CLI Tools

Install [GitHub Desktop](https://desktop.github.com/) if you prefer a GUI Git client. Otherwise, use the CLI clone flow from [Fresh macOS Setup Checklist](#fresh-macos-setup-checklist).

Install Homebrew formulas and casks from the tracked bundle:

```bash
brew bundle check --file=~/dotfiles/scripts/Brewfile || brew bundle install --file=~/dotfiles/scripts/Brewfile
```

Apply tracked dotfile setup:

```bash
~/dotfiles/dot/dot setup --skip-existing --verbose
```

Back up and restore tracked app config with dry-run safety:

```bash
~/dotfiles/dot/dot backup --verbose
~/dotfiles/dot/dot restore --dry-run --verbose
~/dotfiles/dot/dot restore --apply --verbose
```

Back up and restore private machine/company config:

```bash
~/dotfiles/dot/local backup --verbose
~/dotfiles/dot/local restore --from ~/localrc/backup-YYYY-MM-DD --dry-run --verbose
~/dotfiles/dot/local restore --from ~/localrc/backup-YYYY-MM-DD --apply --verbose
```

### Shell

Set up Zsh ([guide](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH)):

```bash
which zsh
grep -Fx "$(which zsh)" /etc/shells || echo "$(which zsh)" | sudo tee -a /etc/shells
chsh -s "$(which zsh)"
```

Set up [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh):

```bash
test -d ~/.oh-my-zsh || sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

test -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
test -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions || git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions

touch ~/.localrc ~/.localenv
```

`zshrc` currently enables `autojump`, `git`, `gitignore`, `golang`, `tmux`, `zsh-completions`, and `zsh-autosuggestions`.

### Tmux

Set up Tmux and [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm):

```bash
test -d ~/.tmux/plugins/tpm || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Start a session
tmux new -s dev

# Reload Tmux environment to source TPM (optional)
tmux source ~/.tmux.conf

# Press prefix (C-b) + I to install plugins
```

### Keyboard Enhancements

Open [Karabiner-Elements](https://karabiner-elements.pqrs.org/) and grant permissions.

`dot/dot setup` copies the main Karabiner config and symlinks custom rules. To re-run only the documented manual steps:

```bash
cp ~/dotfiles/mac/karabiner.json ~/.config/karabiner/karabiner.json
ln -s ~/dotfiles/mac/karabiner-rules ~/.config/karabiner/assets/complex_modifications
```

Refer to [zhuochun/mac-keyboard](https://github.com/zhuochun/mac-keyboard) and Ergodox-EZ layout ([Mac](https://github.com/zhuochun/qmk_firmware/blob/zhuochun-keymaps-3/keyboards/ergodox_ez/keymaps/zhuochun/keymap.c)/[Win](https://configure.ergodox-ez.com/ergodox-ez/layouts/Qz39g/latest/0)).

## Vim / Neovim

Both Mac and Windows use similar key mappings. For muscle memory, `<D-*>` mappings on Mac are `<M-*>` mappings on Windows.

- **macOS:** Use `vim/vimrc` with `brew install neovim` or the tracked Homebrew bundle.
- **Windows:** Use `windows/_vimrc` (not actively updated).

Set up [Shougo/dein.vim](https://github.com/Shougo/dein.vim):

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Shougo/dein-installer.vim/master/installer.sh)"
```

`dot/dot setup` creates the Vim/Neovim symlinks. Manual equivalents are:

```bash
# neovim
ln -s ~/dotfiles/vim/vimrc ~/.config/nvim/init.vim
ln -s ~/dotfiles/vim/rc ~/.config/nvim/rc

# vim
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
ln -s ~/dotfiles/vim/rc ~/.vim/rc
ln -s ~/dotfiles/vim/gvimrc ~/.gvimrc
```

Open Vim/Neovim and install plugins: `:call dein#install()`.

## Windows Setup

### AutoHotkey

I use [AutoHotkey](https://www.autohotkey.com/) in Windows to enhance productivity.

Refer to:

- `windows/AutoHotkey.ahk`
- `windows/AutoHotkey-v2.ahk`
- `windows/AutoHotkey-LLM.ahk`
- `windows/README.md`

## Others

### Custom Scripts

Some useful/interesting scripts are under [`bin/`](https://github.com/zhuochun/dotfiles/tree/master/bin), e.g. PDF renaming helpers.

`zshenv` adds `~/dotfiles/bin` to `PATH`, so `dot/dot setup` plus a new shell should make these available.

### Fonts

Install [Powerline Fonts](https://github.com/powerline/fonts) if your terminal theme needs them.

### Themes

Install [gruvbox](https://github.com/morhetz/gruvbox-contrib) colorscheme for terminal.

### Text Expander

Install [Espanso](https://espanso.org/). `dot/dot setup` symlinks the tracked match files. Manual equivalents are:

```bash
ln -s ~/dotfiles/espanso/match.yml "$HOME/Library/Application Support/espanso/match/base.yml"
ln -s ~/dotfiles/espanso/form.yml "$HOME/Library/Application Support/espanso/match/form.yml"
```

### Rime

[Rime](https://github.com/rime) is a powerful Chinese Input Method Engine.

- Use `Ctrl + ~` to adjust Traditional/Simplified Chinese.

`dot/dot setup` symlinks the macOS Squirrel custom config. Manual equivalent:

```bash
ln -s ~/dotfiles/rime/squirrel.custom.yaml ~/Library/Rime/squirrel.custom.yaml
```

### Atom

Atom is no longer part of the main setup flow. Historical plugin note: `apm install markdown-writer`.
