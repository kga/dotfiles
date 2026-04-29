function fzf-ghq-cd () {
    local selected_dir=$(ghq list | fzf --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd $(ghq root)/${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N fzf-ghq-cd
bindkey '^]' fzf-ghq-cd
