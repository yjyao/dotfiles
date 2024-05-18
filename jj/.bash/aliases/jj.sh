# See ~/.bash/completion/jj.sh for completion.
j() {
  jj.sh "$@"
}
export -f j

jj() {
  jj.sh "$@"
}
export -f jj
