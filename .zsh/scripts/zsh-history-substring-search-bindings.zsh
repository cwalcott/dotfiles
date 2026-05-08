zle -N history-substring-search-up
zle -N history-substring-search-down

bindkey '\e[A' history-substring-search-up
bindkey '\e[B' history-substring-search-down
