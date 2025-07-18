# Zhuochun's dotfiles

A set of files across Mac and Windows.

<details>
  <summary><strong>Table of Contents</strong> (click to expand)</summary>

<!-- TOC depthFrom:2 -->

- [Mac Setup](#mac-setup)
  - [System Preferences](#system-preferences)
  - [Applications](#applications)
  - [Keyboard Enhancements](#keyboard-enhancements)
- [Vim](#vim)
- [Windows Setup](#windows-setup)
  - [AutoHotkey](#autohotkey)
- [Others](#others)
  - [Custom Scripts](#custom-scripts)
  - [Fonts](#fonts)
  - [Rime](#rime)
  - [Atom](#atom)

<!-- /TOC -->
</details>

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

``` bash
# Disable "press and hold" option
defaults write -g ApplePressAndHoldEnabled -bool false
# Display all file extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
```

### Applications

Install [GitHub Desktop](https://desktop.github.com/) and clone this repo ([SSH Setup](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)).

``` bash
git clone git@github.com:zhuochun/dotfiles.git ~/dotfiles
```

Install [Homebrew](https://brew.sh/):

``` bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
Run the setup script to install formulas and create all config symlinks:

``` bash
~/dotfiles/scripts/dot-setup.sh
```

If you prefer the manual steps, review and install brew formulas:

``` bash
brew bundle install --file=~/dotfiles/scripts/Brewfile
```

Setup Zsh ([guide](https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH)):

``` bash
# Check zsh PATH and whether it is in authorized shells list (/etc/shells)
which zsh
# Make zsh the default
chsh -s $(which zsh)
```

Setup [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh):

``` bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions

ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/zshenv ~/.zshenv

touch ~/.localrc
touch ~/.localenv
```

Setup Tmux and [Tmux-Plugins](https://github.com/tmux-plugins/tpm):

``` bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/tmux-theme.conf ~/.tmux-theme.conf

# Start a session
tmux new -s dev

# Reload Tmux environment to source TPM (Optional)
tmux source ~/.tmux.conf

# Press prefix (C-b) + I to install the plugins
```

### Keyboard Enhancements

Open [Karabiner](https://pqrs.org/osx/karabiner/index.html) and grant permissions.

Setup the rules and restart Karabiner.

``` bash
cp ~/dotfiles/mac/karabiner.json ~/.config/karabiner/karabiner.json
```

To customise [rules](https://pqrs.org/osx/karabiner/complex_modifications/):

``` bash
ln -s ~/dotfiles/mac/karabiner-rules ~/.config/karabiner/assets/complex_modifications
```

Refer to [zhuochun/mac-keyboard](https://github.com/zhuochun/mac-keyboard) and Ergodox-EZ layout ([Mac](https://github.com/zhuochun/qmk_firmware/blob/zhuochun-keymaps-3/keyboards/ergodox_ez/keymaps/zhuochun/keymap.c)/[Win](https://configure.ergodox-ez.com/ergodox-ez/layouts/Qz39g/latest/0))

## Vim

Both my Mac/Windows use similar key mappings. For muscle memories, `<D-*>` mappings on Mac are `<M-*>` mappings on Windows.

- **Mac OS:** Use `vimrc` with `brew install neovim`.
- **Windows:** Use `windows/_vimrc` (Not actively updated).

Follow [Shougo/dein.vim](https://github.com/Shougo/dein.vim) or [Shougo/dein-installer.vim](https://github.com/Shougo/dein-installer.vim) to setup the plugin system.

``` bash
sh -c "$(wget -O- https://raw.githubusercontent.com/Shougo/dein-installer.vim/master/installer.sh)"

# it creates ~/.cache/dein directory
```

Setup `vimrc` files:

``` bash
# neovim
ln -s ~/dotfiles/vim/vimrc ~/.config/nvim/init.vim
ln -s ~/dotfiles/vim/rc ~/.config/nvim/rc

# vim
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
ln -s ~/dotfiles/vim/rc ~/.vim/rc
ln -s ~/dotfiles/vim/gvimrc ~/.gvimrc
```

Open vim and install plugins: `:call dein#install()`.

## Windows Setup

### AutoHotkey

I use [AutoHotkey](http://ahkscript.org/) in Windows to enhance productivity.

Refer to `windows/AutoHotkey.ahk`.

## Others

### Custom Scripts

Some useful/interesting scripts are under [/bin](https://github.com/zhuochun/dotfiles/tree/master/bin), e.g. rename PDFs.

``` bash
echo 'export PATH="$HOME/dotfiles/bin:$PATH"' >> ~/.zshrc
```

### Fonts

Install [Powerline Fonts](https://github.com/powerline/fonts).

### Themes

Install [gruvbox](https://github.com/morhetz/gruvbox-contrib) colorscheme for terminal.

### Text Expander

Install [Espanso](https://espanso.org/).

``` bash
ln -s ~/dotfiles/espanso/match.yml $HOME/Library/Application\ Support/espanso/match/base.yml
ln -s ~/dotfiles/espanso/form.yml $HOME/Library/Application\ Support/espanso/match/form.yml
```

### Rime

[Rime](https://github.com/rime) is a powerful Chinese Input Method Engine.

- Use `Ctrl + ~` to adjust Traditional/Simplified Chinese.

``` bash
ln -s ~/dotfiles/rime/squirrel.custom.yaml ~/Library/Rime/squirrel.custom.yaml
```

### Atom

- Install Atom Plugins: `apm install markdown-writer`
