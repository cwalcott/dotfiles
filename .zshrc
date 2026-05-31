# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# completion
autoload -U compinit
compinit

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# history
HISTFILE=$HOME/.zhistory
HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

# cd
setopt autocd

# Allow [ or ] whereever you want
unsetopt nomatch

# use neovim as the visual editor
export VISUAL=nvim
export EDITOR=$VISUAL

# load rbenv if available
if command -v rbenv &>/dev/null; then
    eval "$(rbenv init - zsh)"
fi

# PATH
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/.bin:$PATH"
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"

source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

[[ -f ~/.aliases ]] && source ~/.aliases
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

eval "$(starship init zsh)"
