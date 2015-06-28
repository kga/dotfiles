export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export MANPATH=/usr/local/man:$MANPATH
export PAGER=less
export LESS='--RAW-CONTROL-CHARS --ignore-case'
export EDITOR=vim

export GOPATH=$HOME/go

typeset -U path
path=(
    $GOPATH/bin
    $(go env GOROOT)/bin

    $path
)

eval `gdircolors -b`

umask 022

typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# man zshcontrib
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' get-revision true
zstyle ':vcs_info:*'     formats '%s|%b'
zstyle ':vcs_info:git:*' formats '%b(%i)'
zstyle ':vcs_info:*'     actionformats '%s|%b|%a'
function echo_vcs_info () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
precmd_functions+=echo_vcs_info

autoload -U colors
colors

setopt prompt_subst
PROMPT_EXIT="%{%(?.$fg[green].$fg[red]exit: %?$reset_color
)%}
"
PROMPT_CWD=" $fg[blue]%(7~,%-3~/.../%3~,%~)$reset_color"
PROMPT_REPOS=" %1(v|$fg[green]%1v$reset_color|)"

PROMPT_L="
$fg[white]%D{%H:%M}$reset_color %B$fg[red]%(!.#.>)%b$reset_color "

PROMPT="$PROMPT_EXIT$PROMPT_CWD$PROMPT_REPOS$PROMPT_L"

PROMPT2="%_$fg[green]>$reset_color "
#RPROMPT="[%n@%m]"

fpath=(/usr/local/share/zsh-completions $fpath)

setopt always_last_prompt
setopt always_to_end
setopt append_history
setopt auto_cd
setopt auto_list
setopt auto_menu
setopt auto_param_keys
setopt auto_param_slash
setopt auto_pushd
setopt auto_remove_slash
setopt complete_in_word
setopt correct
#setopt correct_all
#setopt glob_complete
setopt extended_glob
setopt extended_history
setopt hist_ignore_all_dups
setopt list_types
setopt long_list_jobs
#setopt magic_equal_subst
setopt nobeep
setopt print_eight_bit
setopt pushd_ignore_dups
setopt share_history
unsetopt promptcr

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

autoload -U compinit
compinit -u
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
compdef _tex platex

HISTFILE="$HOME/.zhistory"
HISTSIZE=20000
SAVEHIST=100000

bindkey -e
bindkey '' history-beginning-search-backward
bindkey '' history-beginning-search-forward
bindkey '' history-incremental-pattern-search-backward
bindkey '' history-incremental-pattern-search-forward

if [ $(uname) = 'Darwin' ]; then
    LS_OPTIONS=-FG
    alias -g CP='| pbcopy'
    export __CF_USER_TEXT_ENCODING='0x1F5:0x08000100:14'
elif [ $(uname) = 'Linux' ]; then
    LS_OPTIONS=-F --color
fi

alias ls='ls -G'
alias sl='ls'
alias ll='ls -lh'
alias la='ll -a'

alias rm='rm -i'
alias cp='cp -v'
alias mv='mv -iv'
alias tree='tree -NC'

alias v='vim'
alias l='less'
alias lv='less'

alias pd='popd'

function peco-src () {
    local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey '' peco-src

alias st='tig status'

alias -g L='| $PAGER'
alias -g G='| grep'

if [[ "$TERM" == "xterm-256color" || "$TERM" == "xterm" ]]; then
    chpwd () { echo -n "_`dirs`\\" }
    preexec() {
        # see [zsh-workers:13180]
        # http://www.zsh.org/mla/workers/2000/msg03993.html
        emulate -L zsh
        local -a cmd; cmd=(${(z)2})
        case $cmd[1] in
            fg)
                if (( $#cmd == 1 )); then
                    cmd=(builtin jobs -l %+)
                else
                    cmd=(builtin jobs -l $cmd[2])
                fi
                ;;
            %*)
                cmd=(builtin jobs -l $cmd[1])
                ;;
            cd)
                if (( $#cmd >= 2)); then
                    cmd[1]=$cmd[2]
                fi
                ;;
            *)
                echo -n "k$cmd[1]:t\\"
                return
                ;;
        esac

        local -A jt; jt=(${(kv)jobtexts})

        $cmd >>(read num rest
            cmd=(${(z)${(e):-\$jt$num}})
            echo -n "k$cmd[1]:t\\") 2>/dev/null
    }
    chpwd
fi

eval "$(hub alias -s)"

REPORTTIME=10
