# Zhuochun's dotfiles

A set of files across Mac and Windows.

## Vim

Both Mac/Windows use the same key mappings. Excepts the `<D-*>` mappings on Mac are `<M-*>` mappings on Windows.

- **Mac OS:** Use `vimrc`, requires MacVim with `if_lua`:

``` bash
$ brew install macvim --override-system-vim --with-lua --with-luajit
```

- **Windows:** Use `windows/_vimrc`. Not actively updated.

### Vim Setup in Mac

I use [Shougo/neobundle.vim](https://github.com/Shougo/neobundle.vim) to manage plugins.

``` bash
# clone the repository
$ git clone https://github.com/zhuochun/dotfiles.git

# link vimrc
$ ln -s ~/dotfiles/vim ~/.vim
$ ln -s ~/dotfiles/vimrc ~/.vimrc
$ ln -s ~/dotfiles/gvimrc ~/.gvimrc

# install neobundle
# https://github.com/Shougo/neobundle.vim#quick-start
$ curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh

# install plugins
$ vim +NeoBundleInstall +qall
```

To update plugins, run `:NeoBundleUpdate` in Vim.

## Slate/ShiftIt

[Slate](https://github.com/jigish/slate) is a powerful window management application in Mac OS.

``` bash
$ ln -s ~/dotfiles/slate ~/.slate
```

[ShiftIt](https://github.com/fikovnik/ShiftIt) is another window management application in Mac OS.

## Rime

[Rime](https://github.com/rime) is a powerful Chinese Input Method Engine.

## Eclipse

Use Eclipse with [Vrapper](http://vrapper.sourceforge.net/) and some modified shortcuts.

Refer to `vrapperrc` file.

``` bash
$ ln -s ~/dotfiles/eclipse/vrapperrc ~/.vrapperrc
```

## Keyboard Enhancement in Mac

Refer to [zhuochun/mac-keyboard](https://github.com/zhuochun/mac-keyboard).

## AutoHotkey

I use [AutoHotkey](http://ahkscript.org/) in Windows to enhance productivity.

Refer to `windows/AutoHotkey.ahk`.
