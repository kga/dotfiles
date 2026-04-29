unsetopt GLOBAL_RCS

export LANG=ja_JP.UTF-8
export LANGUAGE=ja_JP.UTF-8

export LESS='--RAW-CONTROL-CHARS --IGNORE-CASE --status-column'
export PAGER=less
export EDITOR=nvim

export MYSQL_PS1="(\u@\h) [\d]> "

export GOPATH=$HOME/dev
export HOMEBREW_PREFIX=/opt/homebrew

typeset -U path
path=(
    $HOMEBREW_PREFIX/bin
    $HOMEBREW_PREFIX/sbin
    /usr/local/bin
    /usr/local/sbin
    /usr/sbin

    $GOPATH/bin

    $HOME/bin
    $HOME/.local/bin

    $path
)

umask 022
