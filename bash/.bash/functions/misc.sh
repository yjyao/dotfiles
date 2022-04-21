# Omit file name (and keep only the hash) when hasing only one file.
md5sum() {
  "$(which md5sum)" "$@" | { (( $# > 1 )) && cat || awk '{ print $1 }'; }
}
