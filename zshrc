# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load:
# suvash blinks fino josh re5et random
ZSH_THEME="pure"

# 1 Char Alias
# ==============================
alias a="ag"
alias c="cd"
alias e="mvim"
alias g="git"
alias h="history"
alias l="ls -AlFhG"
alias q="exit"
alias z="zeus"

# 2 Chars Alias
# ==============================

# Copy to clipboard
alias cc="pbcopy"
# Jekyll Server
alias js="jekyll server --watch"
# Node-Webkit Alias
alias nw="~/Documents/Programming/NodeWebkit/v0.8.5/node-webkit.app/Contents/MacOS/node-webkit"
# Heroku
alias he="heroku"
# Rails
alias rk="rake"
# Vim Alias
alias ee="vim"
alias vi="vim"
# IP address
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

# 3 Chars Alias
# ==============================
alias plz="sudo"
alias cls="clear"
alias rmd="rm -rf"
# IP address
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# Other Alias
# ==============================
# Edit zshrc and vimrc
alias zshrc="mvim ~/.zshrc"
alias vimrc="mvim ~/.vimrc"
# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

# Locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Editor
export EDITOR=mvim

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
plugins=(autojump brew bower bundler coffee colored-man gem git git-extras gitignore heroku node npm pip python rails rake rbenv ruby zeus)

# Make sure local/bin first
export PATH="/usr/local/bin:$PATH"
# Add the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
# Add the Postgres database
export PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Ruby environment
eval "$(rbenv init -)"
