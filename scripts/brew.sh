#!/usr/bin/env bash

# Install command-line tools using Homebrew.
# Based on: https://github.com/mathiasbynens/dotfiles/blob/master/brew.sh

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

# Install Bash 4.
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
# brew install bash
# brew tap homebrew/versions
# brew install bash-completion2

# Install Zsh.
brew install zsh
brew install zsh-completions

# Install `wget` with IRI support.
brew install wget --with-iri

# Install RingoJS and Narwhal.
# Note that the order in which these are installed is important;
# see http://git.io/brew-narwhal-ringo.
brew install ringojs
brew install narwhal

# Install MacVim
brew install macvim --override-system-vi --with-lua --with-luajit

# Install NeoVim
brew tap neovim/neovim
brew install neovim

# Install some CTF tools; see https://github.com/ctfs/write-ups.
brew install aircrack-ng
brew install bfg
brew install binutils
brew install binwalk
brew install cifer
brew install dex2jar
brew install dns2tcp
brew install fcrackzip
brew install foremost
brew install hashpump
brew install hydra
brew install john
brew install knock
brew install netpbm
brew install nmap
brew install pngcheck
brew install socat
brew install sqlmap
brew install tcpflow
brew install tcpreplay
brew install tcptrace
brew install ucspi-tcp
brew install xpdf
brew install xz

# Install other useful binaries.
brew install autojump
brew install ack
brew install the_silver_searcher
brew install git
brew install git-lfs
brew install git-imerge
brew install imagemagick --with-webp
brew install lua
brew install lynx
brew install p7zip
brew install pigz
brew install pv
brew install ruby-build
brew install rbenv
brew install rbenv-ctags
brew install rbenv-default-gems
brew install reattach-to-user-namespace
brew install rename
brew install rhino
brew install speedtest_cli
brew install ssh-copy-id
brew install tree
brew install trash
brew install webkit2png
brew install zopfli
brew install jq
brew install httpie
brew install selecta
brew install exa

# Install markdown-to-confluence wiki https://github.com/kentaro-m/md2confl
brew tap kentaro-m/homebrew-md2confl
brew install md2confl

# Remove outdated versions from the cellar.
brew cleanup
