# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="ys"

# Aliases
alias cls="clear"
alias ll="ls -l"
alias la="ls -a"
alias rmf="rm -rf"
# Vim Alias
alias vi="vim"
alias e="mvim"
# Ruby Alias
alias rb="ruby"
# Node-Webkit Alias
alias nw="~/Documents/Programming/NodeWebkit/v0.7.5/node-webkit.app/Contents/MacOS/node-webkit"

# Edit Zshrc and Vimrc
alias zshrc="mvim ~/.zshrc"
alias vimrc="mvim ~/.vimrc"

# Folders
alias cdProg="cd ~/Documents/Programming/"
alias cdGithub="cd ~/Documents/Programming/Github/"
alias cdSnippet="cd ~/Documents/Programming/Github/vim-snippets/snippets/"
alias cdBlog="cd ~/Documents/Blogs/Bicrement/_posts/"
alias cdNote="cd ~/Dropbox/Mac/Note/"
alias cdBicrement="cd ~/Documents/Programming/Web/zhuochun.github.io/_posts/"
alias cd3002="cd ~/Documents/Programming/CG3002/"
alias cd4001="cd ~/Documents/Programming/CG4001/remotely-observed-treatment/"
alias cdDropbox="cd ~/Dropbox/Mac/"

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
plugins=(autojump brew bundler bower cap composer gem git git-extras mercurial node npm osx rails3 ruby rvm )

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# Ruby environment
eval "$(rbenv init -)"

# Add the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Add the Postgres database
export PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"