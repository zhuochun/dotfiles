# dotfiles

- Mac: `vimrc`, require MacVim with `if_lua`
    ```bash
    $ brew install macvim --with-cscope --with-lua --HEAD
    ```
- Windows: `_vimrc`

**NOTE**: Utilize `Alt` on Windows and `Command` on Mac heavily.

# Setup

I use [Shougo/neobundle.vim](https://github.com/Shougo/neobundle.vim) to manage plugins.

This is the setup:

```bash
# clone the repository
$ git clone https://github.com/zhuochun/dotfiles.git

# link to the vimrc (Mac)
$ ln -s dotfiles/vimrc ~/.vimrc
$ ln -s dotfiles/gvimrc ~/.gvimrc

# install neobundle
$ curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh

# install plugins
$ vim +NeoBundleInstall +qall
```

To update plugins, run `:NeoBundleUpdate` in Vim.

# Screenshot on Mac

![MacVim Screenshot](http://i.imgur.com/kMowUrZ.jpg)

# Screenshot on Windows

![Windows gVim Screenshot](http://i.imgur.com/Qs205Th.png)

### From [zhuochun](http://www.bicrement.com)
