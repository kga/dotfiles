umask 022

export LANG=ja_JP.UTF-8
export PATH=/usr/local/bin:/usr/sbin:$HOME/bin:$HOME/local/bin:$HOME/local/flex3sdk/bin:$PATH
export MANPATH=/usr/local/man:$MANPATH
export PAGER=lv
export LV='-Ou -c'
export EDITOR=vim

export GISTY_DIR=$HOME/git/gist

autoload -U colors
colors

setopt prompt_subst
PROMPT_EXIT="%{%(?.$fg[green].$fg[red]exit: %?$reset_color
)%}
"
PROMPT_CWD=" %{$fg[yellow]%}%~%{$reset_color%}"
PROMPT_REPOS="%{$fg[green]%}\$(_echo_git_head)%{$reset_color%}"

#PROMPT_L="
#%{$fg[blue]%}%(!.#.$)%{$reset_color%} "

PROMPT_L="
%{$fg[red]%}ﾉﾉ-@.@)%{$reset_color%} "

PROMPT="$PROMPT_EXIT$PROMPT_CWD$PROMPT_REPOS$PROMPT_L"

PROMPT2="%_$fg[green]>$reset_color "
RPROMPT="[%n@%m]"

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

alias sl='ls'
alias ll='ls -lh'
alias l='ll'
alias la='ll -a'

alias rm='rm -i'
alias cp='cp -v'
alias mv='mv -iv'

alias v='vim'
alias e='emacs'

alias pd='popd'
alias man='w3mman'


alias -g L='| $PAGER'
alias -g G='| grep'
alias -g A='| ack -i'

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

function chpwd () {
    _reg_pwd_screennum
}

function n () {
    screen -X eval "chdir $PWD" "screen" "chdir"
}

#source $HOME/.zsh/perldoc
source $HOME/.zsh/cdd
source $HOME/.zsh/_echo_git_head

if [ `uname` = "Darwin" ]; then
    source $HOME/.zsh/.zshrc.osx
elif [ `uname` = "Linux" ]; then
    source $HOME/.zsh/.zshrc.linux
fi
