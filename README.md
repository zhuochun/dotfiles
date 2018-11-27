# Zhuochun's dotfiles

A set of files across Mac and Windows.

## Vim

Both Mac/Windows use the same key mappings. Excepts the `<D-*>` mappings on Mac are `<M-*>` mappings on Windows to comfort my muscle memory.

- **Mac OS:** Use `vimrc`, requires MacVim with `if_lua`:

``` bash
brew install macvim --override-system-vim --with-lua --with-luajit
```

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

### Keyboard Enhancement in Mac

Refer to [zhuochun/mac-keyboard](https://github.com/zhuochun/mac-keyboard).

Refer to my [Ergodox-EZ](https://github.com/zhuochun/qmk_firmware/blob/zhuochun-keymaps-3/keyboards/ergodox_ez/keymaps/zhuochun/keymap.c) layout.

### Rime

[Rime](https://github.com/rime) is a powerful Chinese Input Method Engine.

- Use `Ctrl + ~` to adjust Traditional/Simplified Chinese.

``` bash
ln -s ~/dotfiles/rime/squirrel.custom.yaml ~/Library/Rime/squirrel.custom.yaml
```

### Slate/ShiftIt

[Slate](https://github.com/jigish/slate) is a powerful window management application in Mac OS.

``` bash
ln -s ~/dotfiles/slate ~/.slate
```

[ShiftIt](https://github.com/fikovnik/ShiftIt) is another window management application in Mac OS.
