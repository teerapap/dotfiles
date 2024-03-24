

# Environment variables
[[ -f ~/.bash/env ]] && source ~/.bash/env

# Run some environment-setup scripts
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

# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
. "$HOME/.bashrc"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


