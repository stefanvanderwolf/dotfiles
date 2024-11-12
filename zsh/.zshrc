# Load the profiling mod to debugging startup times.
#
# @usage:
#
# ```sh
#   time ZSH_DEBUG=1 zsh -i -c exit
# ```
if [ -n "$ZSH_DEBUG" ]; then
  zmodload zsh/zprof
fi

# Should be the last statement to get complete profiling.
if [ -n "$ZSH_DEBUG" ]; then
  zprof
fi
