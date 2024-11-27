# Load the profiling mod to debugging startup times.
#
# @usage:
#
# ```sh
#   time ZSH_DEBUG=1 zsh -i -c exit
# ```
if [ -n "$ZSH_DEBUG" ]; then
  [ -n "$XDG_CACHE_HOME" ] || \
    (>&2 printf 'Null pointer exception on XDG_CACHE_HOME\n' && exit)

  zmodload zsh/zprof
fi

# autoloading {{{1
FPATH="$HOME/git/dotfiles/zsh/functions:$FPATH"
autoload -U $fpath[1]/*(.:t)
# 1}}}

# edit {{{1
export EDITOR='nvim'
export VISUAL='nvim'
alias -g vi='nvim'
alias -g vim='nvim'
# 1}}}

# ls {{{1
alias -g la='ls -la'
# 1}}}

# history {{{1
export HISTSIZE=500
export SAVEHIST=20000
export HISTFILE="$XDG_CACHE_HOME/zsh/history"
export HISTORY_IGNORE="vi *|cd ~|g add*"
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY
# 1}}}

# fzf {{{1
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#000000
  --color=fg+:#000000
  --color=bg:#ffffff
  --color=bg+:#ffffff
  --color=hl:#8000f0
  --color=hl+:#800080
  --color=info:#800080
  --color=marker:#800080
  --color=prompt:#800080
  --color=spinner:#000000
  --color=pointer:#000000
  --color=header:#000000
  --color=border:#000000
  --color=label:#aeaeae
  --color=query:#000000
  --border="none"
  --preview-window="border-rounded"
  --prompt="> "
  --marker=">"
  --pointer="◆"
  --scrollbar="│"
  --bind="ctrl-c:abort"'
# 1}}}

# completion {{{1
setopt globdots

autoload -Uz compinit

compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

compdef g=git
compdef gg=git
# 1}}}

# Should be the last statement to get complete profiling.
if [ -n "$ZSH_DEBUG" ]; then
  zprof

  # Zsh history will not create intermediate directories. If detected the
  # directory doesn't exists just create it.
  [ -d "${HISTFILE%/*}" ] || mkdir -vp "${HISTFILE%/*}"
fi

# vim: foldmethod=marker foldlevel=0
