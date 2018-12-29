# Zhuochun's dotfiles

A set of files across Mac and Windows.

<details>
  <summary><strong>Table of Contents</strong> (click to expand)</summary>

<!-- TOC depthFrom:2 -->

- [Mac Setup (2018)](#mac-setup-2018)
  - [System Preferences](#system-preferences)
  - [Applications](#applications)
  - [Keyboard Enhancements](#keyboard-enhancements)
- [Vim](#vim)
  - [Vim Setup in Mac](#vim-setup-in-mac)
- [AutoHotkey in Windows](#autohotkey-in-windows)
- [Scripts](#scripts)
- [Tools](#tools)
  - [Rime](#rime)

<!-- /TOC -->
</details>

## Mac Setup (2018)

### System Preferences

- Dock -> Position `Left`, Enable `Automatically hide and show`.
- Keyboard -> Keyboard -> Fastest Key Repeat, Shortest Delay, Enable `Standard function keys`.
- Keyboard -> Shortcuts -> Screen Shots -> Disable picture of screen, Remap picture of selected area to `<M-S>` (File) and `<S-M-S>` (Clipboard).
- Trackpad -> Enable `Tap to click`.
- Accessibility -> Mouse & Trackpad -> Trackpad Options -> Enable dragging `Three finger dragging`.

### Applications

Install [Homebrew](https://brew.sh/):

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Setup Zsh ([Guide](https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH)). Then install [Oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh):

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

➜  ~ ln -s ~/dotfiles/zshrc ~/.zshrc
➜  ~ ln -s ~/dotfiles/zshenv ~/.zshenv
```

### Others

- Install Fonts: https://github.com/powerline/fonts
- Install Atom Plugins: `apm install markdown-writer`

### Keyboard Enhancements

Install [Karabiner](https://pqrs.org/osx/karabiner/index.html). Import following [rules](https://pqrs.org/osx/karabiner/complex_modifications/):

- Change return to control if pressed with other keys, to return if pressed alone
- Better Shifting: Parentheses on shift keys
- Finder: Use Return as Open, Use Backspace as Go to Previous Folder, Use F2 as Rename, Use Fn+Delete as Move to Trash

Refer to [zhuochun/mac-keyboard](https://github.com/zhuochun/mac-keyboard) and [Ergodox-EZ/zhuochun](https://github.com/zhuochun/qmk_firmware/blob/zhuochun-keymaps-3/keyboards/ergodox_ez/keymaps/zhuochun/keymap.c).

## Vim

Both Mac/Windows use the same key mappings. Excepts the `<D-*>` mappings on Mac are `<M-*>` mappings on Windows to comfort muscle memories.

- **Mac OS:** Use `vimrc` with MacVim: `brew install macvim neovim`
- **Windows:** Use `windows/_vimrc` (Not actively updated).

### Vim Setup in Mac

I use [Shougo/neobundle.vim](https://github.com/Shougo/neobundle.vim) to manage plugins.

``` bash
# clone the repository
git clone https://github.com/zhuochun/dotfiles.git ~/dotfiles

# link vimrc
ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/gvimrc ~/.gvimrc

# install neobundle
# https://github.com/Shougo/neobundle.vim#quick-start
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh

# install plugins
vim +NeoBundleInstall +qall
```

To update plugins, run `:NeoBundleUpdate` in Vim.

## AutoHotkey in Windows

I use [AutoHotkey](http://ahkscript.org/) in Windows to enhance productivity.

Refer to `windows/AutoHotkey.ahk`.

## Scripts

I created some random/useful scripts under [/bin](https://github.com/zhuochun/dotfiles/tree/master/bin), e.g. rename PDFs.

``` bash
echo 'export PATH="$HOME/dotfiles/bin:$PATH"' >> ~/.zshrc
```

## Tools

### Rime

[Rime](https://github.com/rime) is a powerful Chinese Input Method Engine.

- Use `Ctrl + ~` to adjust Traditional/Simplified Chinese.

``` bash
ln -s ~/dotfiles/rime/squirrel.custom.yaml ~/Library/Rime/squirrel.custom.yaml
```
