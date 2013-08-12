# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/teerapap/.zshrc'

autoload -Uz compinit promptinit
compinit
promptinit
# End of lines added by compinstall

# Environment variables
[[ -f ~/.zsh/env ]] && source ~/.zsh/env

# Init directory colors
eval `dircolors ~/.dir_colors`

# Prompt definitions.
[[ -f ~/.zsh/prompt ]] && source ~/.zsh/prompt

# Alias definitions.
[[ -f ~/.zsh/aliases ]] && source ~/.zsh/aliases

# Add some dirs to shell path
[[ -f ~/.zsh/pathenv.sh ]] && source ~/.zsh/pathenv.sh

# Load NVM
[[ -f ~/.nvm/nvm.sh ]] && source ~/.nvm/nvm.sh

# If not running tmux, run it
if [[ -z "$TMUX" ]]
then
    export TERMINFO=/usr/share/terminfo/x/xterm-256color TERM=xterm-256color  # For vim solarized theme inside tmux
    exec tmux -2
fi
