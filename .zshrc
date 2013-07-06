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

# Init directory colors
eval `dircolors ~/.dir_colors`

# Prompt definitions.
[[ -f ~/.zsh/prompt ]] && source ~/.zsh/prompt

# Alias definitions.
[[ -f ~/.zsh/aliases ]] && source ~/.zsh/aliases

# If not running tmux, run it
[[ -z "$TMUX" ]] && exec tmux
