# dotfiles

## Vim

- **Mac:** `vimrc`, require MacVim with `if_lua`.

``` bash
$ brew install macvim --with-cscope --with-lua --HEAD
```

- **Windows:** `_vimrc`.

**NOTE**: Used in Vim GUI.

### Setup

I use [Shougo/neobundle.vim](https://github.com/Shougo/neobundle.vim) to manage plugins.

``` bash
# clone the repository
$ git clone https://github.com/zhuochun/dotfiles.git

# link to vimrc (Mac)
$ ln -s path_to_dotfiles/vimrc ~/.vimrc
$ ln -s path_to_dotfiles/gvimrc ~/.gvimrc

# install neobundle
# https://github.com/Shougo/neobundle.vim#quick-start
$ curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh

# install plugins
$ vim +NeoBundleInstall +qall
```

To update plugins, run `:NeoBundleUpdate` in Vim.

### Screenshot on Mac

![MacVim Screenshot](http://i.imgur.com/kMowUrZ.jpg)

### Screenshot on Windows

![Windows gVim Screenshot](http://i.imgur.com/Qs205Th.png)

## Slate

[Slate](https://github.com/jigish/slate) is a powerful window management application in Mac OS.

``` bash
$ ln -s path_to_dotfiles/slate ~/.slate
```

## Keyboard Enhancement in Mac

Refer to [zhuochun/mac-keyboard](https://github.com/zhuochun/mac-keyboard).
