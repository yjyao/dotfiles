# um: Personal man pages.

alias um='man -S jy'
alias umedit='__umedit'

__umedit() {
  if [ ! -d "$HOME/.man/manjy" ]; then
    >&2 echo "FATAL: missing required directory $HOME/.man/manjy"
    return 1
  fi
  if [ -n "$1" ]; then
    "${EDITOR:-vim}" "$HOME/.man/manjy/$1.jy"
  else
    >&2 echo "USAGE: $FUNCNAME PAGE"
    return 1
  fi
}
