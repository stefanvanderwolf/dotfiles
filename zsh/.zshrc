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

# edit {{{1
export EDITOR='nvim'
export VISUAL='nvim'
alias -g vi='nvim'
alias -g vim='nvim'
# 1}}}

# history {{{1
export HISTSIZE=500
export SAVEHIST=20000
export HISTFILE="$XDG_CACHE_HOME/zsh/history"
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
# 1}}}

# Should be the last statement to get complete profiling.
if [ -n "$ZSH_DEBUG" ]; then
  zprof

  # Zsh history will not create intermediate directories. If detected the
  # directory doesn't exists just create it.
  [ -d "${HISTFILE%/*}" ] || mkdir -vp "${HISTFILE%/*}"
fi

# vim: foldmethod=marker foldlevel=0
