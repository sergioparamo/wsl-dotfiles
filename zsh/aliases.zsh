# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias c="clear"

# Git
alias gst="git status"
alias gco="git checkout"
alias gcm="git commit"
alias gp="git push"

# Docker aliases
alias dps="docker ps"
alias dstop="docker stop \$(docker ps -q)"
alias dclean="docker system prune -af"

# FZF
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'