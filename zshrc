# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load:
# dst blinks bira josh norm ys jtriley rkj-repos random
ZSH_THEME="suvash"

# System Aliases
alias plz=sudo
alias cls=clear
alias rmd="rm -rf"
alias h=history
alias q=exit
# Copy to clipboard
alias cc=pbcopy
# Vim Alias
alias e=mvim
alias ee=vim
alias vi=vim
# Others
alias g=git
alias ra=rake
alias js="jekyll server --watch"
# Node-Webkit Alias
alias nw=~/Documents/Programming/NodeWebkit/v0.7.5/node-webkit.app/Contents/MacOS/node-webkit

# Edit zshrc and vimrc
alias zshrc="mvim ~/.zshrc"
alias vimrc="mvim ~/.vimrc"

# open files in vim
alias -s html=vim
alias -s xml=vim
alias -s css=vim
alias -s less=vim
alias -s js=vim
alias -s json=vim
alias -s rb=vim
alias -s asm=vim
alias -s c=vim
alias -s h=vim
alias -s cpp=vim
alias -s txt=vim

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

# Locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(autojump brew bower cap gem git git-extras heroku node npm osx rails3 rbenv ruby tmux zeus)

source $ZSH/oh-my-zsh.sh

# Ruby environment
eval "$(rbenv init -)"

# Add the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Add the Postgres database
export PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
