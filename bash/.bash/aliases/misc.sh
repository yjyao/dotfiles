# Usage:
#     $ jsonprint <<< '{ "obj": { "key": "value" } }'
if python3 -c 'import json.tool' &>/dev/null; then
  alias jsonprint='python3 -m json.tool'
elif python -c 'import json.tool' &>/dev/null; then
  alias jsonprint='python -m json.tool'
fi

command -v recap &>/dev/null && alias recap='recap -d "5 hours ago"'

command -v telegram-cli &>/dev/null && alias tg='telegram-cli -l1 -NAW'

# In some distributions https://github.com/sharkdp/fd is installed as `fdfind`.
# Alias that to `fd`.
command -v fdfind &>/dev/null && ! command -v fd &>/dev/null && alias fd=fdfind

# an online snake game
alias tron="ssh sshtron.zachlatta.com"
