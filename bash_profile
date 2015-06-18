# 1 Char Alias
# ==============================
alias e="mvim"
alias g="git"
alias h="history"
alias l="ls -AlFhG"
alias o="open"
alias p="ps -f"
alias q="exit"

# 2 Chars Alias
# ==============================
alias ee="vim"
alias vi="vim"
alias cl="clear"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

# 3 Chars Alias
# ==============================
alias plz="sudo !!"
alias rmd="rm -rf"
alias ccp="pbcopy"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# Env Variables
# ==============================
export PATH="$HOME/.rbenv/bin:$PATH"
export EDITOR=vim

# colors
export CLICOLOR=true
export GREP_OPTIONS="--color=auto"
export LESS="--RAW-CONTROL-CHARS"

# Others
# ==============================
# rbenv
eval "$(rbenv init -)"
# autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
