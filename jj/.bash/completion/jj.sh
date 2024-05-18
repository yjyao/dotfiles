# Requires https://github.com/martinvonz/jj.

if command -v jj &>/dev/null; then
  source <(jj util completion bash)
fi

# See ~/.bash/aliases/jj.sh for alias definition.
if command -v _jj &> /dev/null; then
  complete -F _jj -o bashdefault -o default j
fi
