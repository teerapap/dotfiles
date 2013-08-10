

if [[ -f ~/.pathenv ]] # Iterate over lines in ~/.pathenv
then
    for p in `cat ~/.pathenv`
    do
        # tilde expansion
        eval rp=$p
        if [ -d "$rp" ] && [[ ":$PATH:" != *":$rp:"* ]]
        then
            PATH="$PATH:$rp"
        fi
    done
fi

