vimdiff() {
  local left="${1?}" right="${2?}"
  shift 2
  if [[ -d "${left}" && -d "${right}" ]]; then
    vim "+DirDiff ${left} ${right}" -c "2 wincmd w" "$@"
  else
    command vimdiff -d "${left}" "${right}" -c "2 wincmd w" "$@"
  fi
}
alias vd=vimdiff
