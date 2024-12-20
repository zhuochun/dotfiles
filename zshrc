# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load:
# Look in ~/.oh-my-zsh/themes/
# suvash blinks fino josh re5et random
ZSH_THEME="refined"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Zsh Plugins
# ==============================
# Plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(autojump git gitignore golang tmux
         zsh-completions zsh-autosuggestions)

# zsh-completions https://github.com/zsh-users/zsh-completions
autoload -U compinit && compinit

# Load oh-my-zsh
# ==============================
source $ZSH/oh-my-zsh.sh

# Configs
# ==============================
export TERM=xterm-256color

# Command line head / tail shortcuts
# ==============================
alias -g A="| ag"
alias -g H="| head"
alias -g T="| tail"
alias -g G="| grep"
alias -g L="| less"
alias -g M="| most"

alias -g CP="| pbcopy"
alias -g PM="2>&1 | pygmentize -l pytb"
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"

alias -g NGO="--ignore '*_test.go'"
alias -g NUL="> /dev/null 2>&1"
alias -g GRP="| sort | uniq -c | sort -r"

# 1 Char Alias
# ==============================
alias a="ag"
alias b="brew"
alias e="nvim"
alias g="git"
alias h="history"
alias l="ls -lF"
alias n="nvim"
alias m="man"
alias o="open"
alias p="ps -f"
alias q="exit"
alias t="tail -f"

# 2 Chars Alias
# ==============================
# Rails
alias ra="rake"
alias br="bin/rake"
# Vim Alias
alias ee="nvim"
alias vi="nvim"
# Tmux
alias tm="tmux"
# Git
alias gm="git-imerge"
alias gv="nvim -c MagitOnly"
# System
alias ll="ls -alF"
alias cl="clear"
alias rm="trash"
# Network IP address
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

# 3 Chars Alias
# ==============================
# System
alias plz="sudo"
alias rmd="trash"
# Vim
alias vim="nvim"
# Copy to clipboard
alias ccp="pbcopy"
# Local IP address
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
# Top 10 history
alias h10="print -l ${(o)history%% *} | uniq -c | sort -nr | head -n 10"

# Other Alias
# ==============================
# Edit zshrc and vimrc
alias zshrc="nvim ~/.zshrc"
alias vimrc="nvim ~/.vimrc"
# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"
# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"

# Function Helpers
# ==============================
function ywd {
    pwd | tr -d "\r\n" | pbcopy
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
    tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

# https://github.com/y0ssar1an/q
function qq() {
    clear

    logpath="$TMPDIR/q"
    if [[ -z "$TMPDIR" ]]; then
        logpath="/tmp/q"
    fi

    if [[ ! -f "$logpath" ]]; then
        echo 'Q LOG' > "$logpath"
    fi

    tail -100f -- "$logpath"
}

function rmqq() {
    logpath="$TMPDIR/q"
    if [[ -z "$TMPDIR" ]]; then
        logpath="/tmp/q"
    fi
    if [[ -f "$logpath" ]]; then
        rm "$logpath"
    fi
    qq
}

# Local configs
[ -f ~/.localrc ] && source ~/.localrc
