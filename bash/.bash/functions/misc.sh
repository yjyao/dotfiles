# Omit file name (and keep only the hash) when hasing only one file.
md5sum() {
  "$(which md5sum)" "$@" | { (( $# > 1 )) && cat || awk '{ print $1 }'; }
}

# Coalesces values, keeping the first where `func(val)` returns 0.
coalesce_f() {
  local func="${1?}"; shift
  for var in "$@"; do
    "${func}" "${var}" && { echo "${var}"; return; }
  done
  return 1
}
