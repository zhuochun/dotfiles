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

- Dock -> Position `Left`, Enable `Automatically hide and show`.
- Keyboard -> Keyboard -> Fastest Key Repeat, Shortest Delay, Enable `Standard function keys`.
- Keyboard -> Keyboard -> Change `Caps Lock` to `Command` key.
- Keyboard -> Shortcuts -> Screen Shots -> Disable picture of screen, Remap picture of selected area to `<M-s>` (File) and `<M-S>` (Clipboard).
- Keyboard -> Input Sources -> Add `Pinyin - Simplified`.
- Trackpad -> Enable `Tap to click`.
- Accessibility -> Mouse & Trackpad -> Trackpad Options -> Enable dragging `Three finger dragging`.

Other preferences:

``` bash
# Disable "press and hold" option
defaults write -g ApplePressAndHoldEnabled -bool false
# Display all file extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
```

### Applications

``` bash
git clone git@github.com:zhuochun/dotfiles.git ~/dotfiles
```

Install [Homebrew](https://brew.sh/):

``` bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew bundle install --file=~/dotfiles/scripts/Brewfile
```

Setup Zsh ([guide](https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH)) and [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh):

``` bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/zshenv ~/.zshenv

touch ~/.localrc
touch ~/.localenv
```

Setup Tmux and [Tmux-Plugins](https://github.com/tmux-plugins/tpm):

``` bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

tmux new -s dev

ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/tmux-osx.conf ~/.tmux-osx.conf
ln -s ~/dotfiles/tmux-theme.conf ~/.tmux-theme.conf

# Reload Tmux environment to source TPM
# After source, Press prefix + I to install the plugins
tmux source ~/.tmux.conf
```

### Keyboard Enhancements

Setup [Karabiner](https://pqrs.org/osx/karabiner/index.html):

```
cp ~/dotfiles/mac/karabiner.json ~/.config/karabiner/karabiner.json
```

To customise [rules](https://pqrs.org/osx/karabiner/complex_modifications/):

```
ln -s ~/dotfiles/mac/karabiner-rules ~/.config/karabiner/assets/complex_modifications
```

Refer to [zhuochun/mac-keyboard](https://github.com/zhuochun/mac-keyboard) and [Ergodox-EZ/zhuochun](https://github.com/zhuochun/qmk_firmware/blob/zhuochun-keymaps-3/keyboards/ergodox_ez/keymaps/zhuochun/keymap.c).

## Vim

Both my Mac/Windows use similar key mappings. For muscle memories, `<D-*>` mappings on Mac are `<M-*>` mappings on Windows.

- **Mac OS:** Use `vimrc` with `brew install neovim`.
- **Windows:** Use `windows/_vimrc` (Not actively updated).

Setup [Shougo/dein.vim](https://github.com/Shougo/dein.vim) for plugins:

``` bash
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
# Set `~/.vim/bundles` as installation directory
sh ./installer.sh ~/.vim/bundles
```

Setup `vimrc` configs:

``` bash
ln -s ~/dotfiles/vim/rc ~/.vim/rc
# vim
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
ln -s ~/dotfiles/vim/gvimrc ~/.gvimrc
# neovim
ln -s ~/dotfiles/vim/vimrc ~/.config/nvim/init.vim
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

### Rime

[Rime](https://github.com/rime) is a powerful Chinese Input Method Engine.

- Use `Ctrl + ~` to adjust Traditional/Simplified Chinese.

``` bash
ln -s ~/dotfiles/rime/squirrel.custom.yaml ~/Library/Rime/squirrel.custom.yaml
```

### Atom

- Install Atom Plugins: `apm install markdown-writer`
