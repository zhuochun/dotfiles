#!/usr/bin/env bash

# Install Homebrew packages
brew bundle install --file=~/dotfiles/scripts/Brewfile

# oh-my-zsh setup
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ] && git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions"

ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/zshenv ~/.zshenv

touch ~/.localrc
touch ~/.localenv

grep -qxF 'export PATH="$HOME/dotfiles/bin:$PATH"' ~/.zshrc || echo 'export PATH="$HOME/dotfiles/bin:$PATH"' >> ~/.zshrc

# Tmux setup
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/tmux-theme.conf ~/.tmux-theme.conf

# Karabiner setup
mkdir -p ~/.config/karabiner/assets/complex_modifications
cp ~/dotfiles/mac/karabiner.json ~/.config/karabiner/karabiner.json
ln -sf ~/dotfiles/mac/karabiner-rules ~/.config/karabiner/assets/complex_modifications

# Vim setup
mkdir -p ~/.config/nvim
ln -sf ~/dotfiles/vim/vimrc ~/.config/nvim/init.vim
ln -sf ~/dotfiles/vim/rc ~/.config/nvim/rc

mkdir -p ~/.vim
ln -sf ~/dotfiles/vim/vimrc ~/.vimrc
ln -sf ~/dotfiles/vim/rc ~/.vim/rc
ln -sf ~/dotfiles/vim/gvimrc ~/.gvimrc

# Espanso setup
ESPANSO_DIR="$HOME/Library/Application Support/espanso/match"
mkdir -p "$ESPANSO_DIR"
ln -sf "$HOME/dotfiles/espanso/match.yml" "$ESPANSO_DIR/base.yml"
ln -sf "$HOME/dotfiles/espanso/form.yml" "$ESPANSO_DIR/form.yml"

# Rime setup
mkdir -p "$HOME/Library/Rime"
ln -sf "$HOME/dotfiles/rime/squirrel.custom.yaml" "$HOME/Library/Rime/squirrel.custom.yaml"
