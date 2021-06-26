autoload -U colors
colors

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
HISTSIZE=100000
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
alias ll='ls -lh'
alias la='ll -a'

alias rm='rm -i'
alias cp='cp -v'
alias mv='mv -iv'
alias tree='tree -NC'

alias v='nvim'
alias vim='nvim'
alias l='less'
alias lv='less'

alias pd='popd'

alias ce='carton exec'
alias be='bundle exec'

alias gi='git'
alias g='git'
alias gitst='git st'
alias issues='hub issue'
issue () { hub browse -- issues/$1 }

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

for f (~/.zsh/**/*.zsh) source "${f}"

### peco ###
bindkey '^g' peco-git-branch-checkout
bindkey '^r' peco-select-history

source /usr/local/share/zsh/site-functions/_aws

eval "$(starship init zsh)"
