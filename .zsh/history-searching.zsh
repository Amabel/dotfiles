# History search)
# Requires peco
# https://github.com/peco/peco
function peco-history-selection() {
    BUFFER="$(\history -nr 1 | awk '!a[$0]++' | peco --query "$LBUFFER" | sed 's/\\n/\n/')"
    CURSOR=$#BUFFER             # カーソルを文末に移動
    zle -R -c                   # refresh
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection
