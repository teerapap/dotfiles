
# Environment variables
[[ -f ~/.zsh/env ]] && source ~/.zsh/env

# Init directory colors
if hash dircolors 2>/dev/null; then
  eval `dircolors ~/.dir_colors`
fi

# Prompt definitions.
[[ -f ~/.zsh/prompt ]] && source ~/.zsh/prompt

# Alias definitions.
[[ -f ~/.zsh/aliases ]] && source ~/.zsh/aliases

# Run some environemnt-setup scripts
if [[ -d ~/.env ]] # Iterate over files in ~/.env
then
    for p in `ls ~/.env/*.sh`
    do
        if [ -x "$p" ]
        then
            source $p
        fi
    done
fi

