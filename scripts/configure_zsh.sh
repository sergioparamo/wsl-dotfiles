#!/usr/bin/env bash
# Zsh, Oh My Zsh, plugins, and configuration
set -e

echo "🌀 Configuring Zsh and Oh My Zsh..."

# Install Zsh if missing
if ! command -v zsh &> /dev/null; then
    sudo apt install -y zsh
fi

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Plugins
plugins_dir="$HOME/.oh-my-zsh/custom/plugins"
mkdir -p "$plugins_dir"

# zsh-autosuggestions
[ ! -d "$plugins_dir/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions "$plugins_dir/zsh-autosuggestions"
# zsh-syntax-highlighting
[ ! -d "$plugins_dir/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting "$plugins_dir/zsh-syntax-highlighting"
# zoxide
[ ! -d "$plugins_dir/zoxide" ] && git clone https://github.com/ajeetdsouza/zoxide.git "$plugins_dir/zoxide"

# FZF
if ! command -v fzf &> /dev/null; then
    sudo apt install -y fzf
fi

# Setup Zsh config
cat > "$HOME/.zshrc" << 'EOF'
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting fzf zoxide)

source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"

# Aliases
alias ll='ls -lah'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gco='git checkout'
alias gd='git diff'
alias dps='docker ps'
alias dstop='docker stop $(docker ps -aq)'
alias dclean='docker system prune -af'

# FZF keybindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
EOF

# Set Zsh as default shell
chsh -s $(which zsh)


echo "✅ Zsh configured!"