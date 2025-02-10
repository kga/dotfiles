autoload -U colors && colors

fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

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

autoload -Uz compinit && compinit -u
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

HISTFILE="$HOME/.zhistory"
HISTSIZE=100000
SAVEHIST=100000

bindkey -e
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

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

alias vi='vim'
alias vim='nvim'

alias ce='carton exec'
alias be='bundle exec'

alias -g L='| $PAGER'
alias -g G='| grep'

REPORTTIME=10

for f (~/.zsh/**/*.zsh) source "${f}"

eval "$(starship init zsh)"

# https://github.com/junegunn/fzf#using-homebrew
# $(brew --prefix)/opt/fzf/install
export FZF_CTRL_R_OPTS="--height=100%"
eval "$(fzf --zsh)"
