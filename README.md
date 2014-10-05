# Zhuochun's dotfiles

## Vim

- **Mac OS:** Use `vimrc`, require MacVim with `if_lua`.

``` bash
$ brew install macvim --with-cscope --with-lua --HEAD
```

- **Windows:** Use `_vimrc`.

**NOTE**: Optimized for (Vim) GUI.

### Setup in Mac

I use [Shougo/neobundle.vim](https://github.com/Shougo/neobundle.vim) to manage plugins.

``` bash
# clone the repository
$ git clone https://github.com/zhuochun/dotfiles.git

# link vimrc
$ ln -s path_to_dotfiles/vimrc ~/.vimrc
$ ln -s path_to_dotfiles/gvimrc ~/.gvimrc

# install neobundle
# https://github.com/Shougo/neobundle.vim#quick-start
$ curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh

# install plugins
$ vim +NeoBundleInstall +qall
```

To update plugins, run `:NeoBundleUpdate` in Vim.

## Slate

[Slate](https://github.com/jigish/slate) is a powerful window management application in Mac OS.

``` bash
$ ln -s path_to_dotfiles/slate ~/.slate
```

## Rime

[Rime](https://code.google.com/p/rimeime/) is a powerful Chinese Input Method Engine.

## Eclipse

I use Eclipse with [Vrapper](http://vrapper.sourceforge.net/). I also modified some shortcuts.

Refer to `vrapperrc` file.

``` bash
$ ln -s path_to_dotfiles/eclipse/vrapperrc ~/.vrapperrc
```

## Keyboard Enhancement in Mac

Refer to [zhuochun/mac-keyboard](https://github.com/zhuochun/mac-keyboard).

## AutoHotkey

I use [AutoHotkey](http://ahkscript.org/) in Windows to enhance productivity.

Refer to `windows/AutoHotkey.ahk`.
