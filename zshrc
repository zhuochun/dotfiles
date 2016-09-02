# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load:
# Look in ~/.oh-my-zsh/themes/
# suvash blinks fino josh re5et random
ZSH_THEME="pure"

# Zsh Plugins
# ==============================
# Plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(atom autojump bower brew brew-cask bundler coffee colored-man gem
         git git-extras gitignore golang jsontools k mix node npm rails rake
         rbenv redis-cli rsync ruby themes tmux vagrant zsh-syntax-highlighting
         zsh-autosuggestions)

# Load oh-my-zsh
# ==============================
source $ZSH/oh-my-zsh.sh

# Command line head / tail shortcuts
# ==============================
alias -g A='| ag'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g M="| most"
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias -g P="2>&1| pygmentize -l pytb"

# 1 Char Alias
# ==============================
alias a="ag"
alias b="brew"
alias e="mvim"
alias g="git"
alias h="history"
alias l="ls -AlFhG"
alias n="nvim"
alias m="man"
alias o="open"
alias p="ps -f"
alias q="exit"
alias t='tail -f'

# 2 Chars Alias
# ==============================
# Rails
alias ra="rake"
alias br="bin/rake"
# Vim Alias
alias ee="vim"
alias vi="vim"
# Git
alias gm="git-imerge"
alias gv="vim -c MagitOnly"
# Oh Emacs
alias em="/Applications/Emacs.app/Contents/MacOS/Emacs"
# System
alias ll="ls -lFhG"
alias cl="clear"
alias rm="trash"
# Network IP address
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

# 3 Chars Alias
# ==============================
# System
alias plz="sudo"
alias rmd="trash"
# Copy to clipboard
alias ccp="pbcopy"
# Local IP address
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
# Top 10 history
alias h10="print -l ${(o)history%% *} | uniq -c | sort -nr | head -n 10"

# Other Alias
# ==============================
# Edit zshrc and vimrc
alias zshrc="gvim ~/.zshrc"
alias vimrc="gvim ~/.vimrc"
# Open vim Magit
alias magit="vim -c MagitOnly"
# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"
# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"

# Function Helpers
# ==============================
function ywd {
  pwd | tr -d "\r\n" | pbcopy
}

# Local configs
if [[ -a ~/.localrc ]]; then source ~/.localrc; fi
