# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load:
# suvash blinks fino josh re5et random
ZSH_THEME="pure"

# 1 Char Alias
# ==============================
alias a="ag"
alias b="brew"
alias c="cd"
alias e="mvim"
alias g="git"
alias h="history"
alias l="ls -AlFhG"
alias o="open"
alias p="ps -f"
alias q="exit"

# 2 Chars Alias
# ==============================

# Jekyll Server
alias js="jekyll server --watch --future"
# Node-Webkit Alias
alias nw="~/Documents/Programming/NodeWebkit/v0.10.5/node-webkit.app/Contents/MacOS/node-webkit"
# Heroku
alias he="heroku"
# Rails
alias ra="rake"
alias br="bin/rake"
# Vim Alias
alias ee="vim"
alias vi="vim"
# System
alias cl="clear"
# Network IP address
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

# 3 Chars Alias
# ==============================
# Jekyll Server DevMode
alias jsd="jekyll server --watch --future --config _config.dev.yml"
# System
alias plz="sudo"
alias rmd="rm -rf"
# Copy to clipboard
alias ccp="pbcopy"
# Local IP address
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
# Top 10 history
alias h10="print -l ${(o)history%% *} | uniq -c | sort -nr | head -n 10"

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
export EDITOR=vim

# Highlight section titles in manual pages
export LESS_TERMCAP_md="${yellow}";

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto";

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
plugins=(autojump atom bower brew bundler coffee colored-man gem git git-extras gitignore heroku mercurial node npm pip python rails rake rbenv rsync ruby vagrant zsh-syntax-highlighting)

# Make sure local/bin first
export PATH="/usr/local/bin:$PATH"
# Add Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
# Add Postgres database
export PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
# Add Android tools
export JAVA_HOME=$(/usr/libexec/java_home)
export ADT_HOME="/Users/zhuochun/Documents/Programming/Android/adt-bundle-mac-x86_64-20140702/sdk"
export PATH="$ADT_HOME/platform-tools:$ADT_HOME/tools:$PATH"

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Ruby environment using rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
