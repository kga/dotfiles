function fzf-git-branch-switch () {
    git for-each-ref \
        --sort=-authordate \
        --format='%(authordate:short)       %(refname)' refs/heads \
        | sed 's/refs\/heads\///' \
        | fzf --no-sort \
        | awk '{ print $NF }' \
        | xargs git switch
    zle accept-line
}
zle -N fzf-git-branch-switch
bindkey '^g' fzf-git-branch-switch
