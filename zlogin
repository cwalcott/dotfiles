# adds the current branch name in green
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo "[%{$fg_bold[green]%}${ref#refs/heads/}%{$reset_color%}]"
  fi
}

# show if working tree is dirty
parse_git_dirty() {
  git_status=$(git status -s 2> /dev/null)
  if [[ -n $git_status ]]; then
    echo " %{$fg[yellow]%}✗%{$reset_color%}"
  fi
}

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

# expand functions in the prompt
setopt promptsubst

# prompt
export PS1='$(git_prompt_info)[${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%~%{$reset_color%}]$(parse_git_dirty) '

# load thoughtbot/dotfiles scripts
export PATH="$HOME/.bin:$PATH"

# Local config
[[ -f ~/.zlogin.local ]] && source ~/.zlogin.local
