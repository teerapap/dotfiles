#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# bash completion following sudo command
complete -cf sudo

# Environment variables
[[ -f ~/.bash/env ]] && source ~/.bash/env

# Init directory colors
eval `dircolors ~/.dir_colors`

# Prompt definitions.
[[ -f ~/.bash/prompt ]] && source ~/.bash/prompt

# Alias definitions.
[[ -f ~/.bash/aliases ]] && source ~/.bash/aliases

# Add some dirs to shell path
[[ -f ~/.bash/pathenv.sh ]] && source ~/.bash/pathenv.sh

# Load NVM
[[ -f ~/.nvm/nvm.sh ]] && source ~/.nvm/nvm.sh

# If not running tmux, run it
if [[ -z "$TMUX" ]]
then
    export TERMINFO=/usr/share/terminfo/x/xterm-256color TERM=xterm-256color  # For vim solarized theme inside tmux
    exec tmux -2
fi
