unsetopt GLOBAL_RCS

export LANG=ja_JP.UTF-8
export LANGUAGE=ja_JP.UTF-8

export LESS='--RAW-CONTROL-CHARS --IGNORE-CASE --status-column'
export PAGER=less
export EDITOR=vim

export MYSQL_PS1="(\u@\h) [\d]> "

export GOPATH=$HOME/dev

typeset -U path
path=(
    /usr/local/bin
    /usr/local/sbin
    /usr/sbin

    $GOPATH/bin

    $HOME/bin
    $HOME/.asdf/shims

    $path
)

#export SSL_CERT_FILE="$(brew --prefix)/etc/openssl/cert.pem"

[ -f /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"

umask 022
