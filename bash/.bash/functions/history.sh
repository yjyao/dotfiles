# Removes an entry from history.
histdel() {
  history -n || return 1
  if (( $# > 0 )); then
    local n="$1"
  elif type fzf &>/dev/null; then
    local n="$(history | tac | fzf -e | awk "{print \$1}")"
  else
    >&2 echo "$FUNCNAME: You must provide an entry ID to delete. Aborted."
    return 1
  fi
  history -d "$n" && history -w
}
