# Requires https://github.com/martinvonz/jj.

if command -v jj &>/dev/null; then
  source <(jj util completion bash)
fi
