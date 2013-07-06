#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# bash completion following sudo command
complete -cf sudo

# Init directory colors
eval `dircolors ~/.dir_colors`

# Prompt definitions.
[[ -f ~/.bash/prompt ]] && source ~/.bash/prompt

# Alias definitions.
[[ -f ~/.bash/aliases ]] && source ~/.bash/aliases

# If not running tmux, run it
[[ -z "$TMUX" ]] && exec tmux
