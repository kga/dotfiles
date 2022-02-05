unsetopt GLOBAL_RCS

export LANG=ja_JP.UTF-8
export LANGUAGE=ja

export MANPATH=/usr/local/man:$MANPATH
export LESS='--RAW-CONTROL-CHARS --IGNORE-CASE --status-column'
export PAGER=less
export EDITOR=vim

export MYSQL_PS1="(\u@\h) [\d]> "

export GOPATH=$HOME/dev

typeset -U path
path=(
    /usr/local/bin
    /usr/local/sbin
    /usr/local/opt/ruby/bin
    /usr/sbin

    /usr/local/opt/mysql@5.6/bin

    $GOPATH/bin

    $HOME/bin

    $path
)

#export SSL_CERT_FILE="$(brew --prefix)/etc/openssl/cert.pem"

umask 022
