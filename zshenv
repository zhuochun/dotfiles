# Environment Configurations
# ==============================
export PATH="$HOME/dotfiles/bin:$PATH"
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH"

# Prefer US English and use UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Editor
export EDITOR=nvim

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

# Highlight section titles in manual pages
export LESS_TERMCAP_md="${yellow}";

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto";

# Local env config
if [[ -a ~/.localenv ]]; then source ~/.localenv; fi
