# man zshcontrib
autoload -Uz vcs_info
zstyle ':vcs_info:*' max-exports 3
zstyle ':vcs_info:*+*:*' debug false
zstyle ':vcs_info:git:*' get-revision true
zstyle ':vcs_info:*'     formats '%s|%b'
zstyle ':vcs_info:git:*' formats       '%b(%i)' '%c%u'
zstyle ':vcs_info:*'     actionformats '%b(%i)' '%c%u' '(!%a)'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr '-'
zstyle ':vcs_info:git:*' stagedstr '+'

autoload -Uz add-zsh-hook

# man zshcontrib -> Hooks in vcs_info -> set-message
## $1: n == $vcs_info_msg_{n}_ 何番目の formats か
zstyle ':vcs_info:git+set-message:*' hooks \
                                         git-hook-shorten-revision \
                                         git-hook-inside-work-tree \
                                         git-hook-untracked

# $vcs_info_msg_0_
# sha1 を 8 桁にする
function +vi-git-hook-shorten-revision() {
    if [[ $1 == 0 ]]; then
        hook_com[revision]=${hook_com[revision]:0:8}
    fi
}

# この hook 以降は work-tree 内じゃないと実行されない
function +vi-git-hook-inside-work-tree() {
    if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
        return 1
    fi

    return 0
}

# $vcs_info_msg_1_
# untracked があったら unstaged の + のうしろに ? をつける
function +vi-git-hook-untracked() {
    if [[ $1 == 1 ]]; then
        if command git status --porcelain 2> /dev/null \
            | awk '{print $1}' \
            | command grep -F '??' > /dev/null 2>&1 ; then

            hook_com[unstaged]+='?'
        fi
    fi
}

function echo_vcs_info() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info

    [[ -n $vcs_info_msg_0_ ]] && psvar[1]=$vcs_info_msg_0_ # %b(%i)
    [[ -n $vcs_info_msg_1_ ]] && psvar[2]=$vcs_info_msg_1_ # %c%u
    [[ -n $vcs_info_msg_2_ ]] && psvar[3]=$vcs_info_msg_2_ # (!%a)
}
add-zsh-hook precmd echo_vcs_info

autoload -U colors
colors

PROMPT_EXIT="%(?..%{$fg[red]%}exit: %?%{$reset_color%})
"
PROMPT_CWD=" %{$fg[blue]%}%(7~,%-3~/.../%3~,%~)%{$reset_color%}"
# man zshmisc -> CONDITIONAL SUBSTRINGS IN PROMPTS
PROMPT_REPOS="%(2V|%{$fg[yellow]%} %2v%{$reset_color%}|)%(3V| %{$fg[red]%}%3v%{$reset_color%}|)%(1V|%{$fg[green]%} %1v%{$reset_color%}|)"

PROMPT_L="
%D{%H:%M} %{$fg[red]%}%(!.#.>)%{$reset_color%} "

PROMPT="$PROMPT_EXIT$PROMPT_CWD$PROMPT_REPOS$PROMPT_L"

PROMPT2="%_%{$fg[green]%}>%{$reset_color%} "
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
