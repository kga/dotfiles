typeset -U path
path=(
    /usr/local/bin
    /usr/local/sbin
    /usr/sbin

    $HOME/bin

    $path
)
eval "$(plenv init -)"
eval "$(rbenv init -)"
