# See ~/.bash/aliases/git.sh for alias definition.
if command -v __git_complete &> /dev/null; then
  __git_complete g __git_main
fi
