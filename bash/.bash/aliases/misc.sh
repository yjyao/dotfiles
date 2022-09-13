# Usage:
#     $ jsonprint <<< '{ "obj": { "key": "value" } }'
#
# This definition delays the (slow) evaluation of available `json.tool`
# libraries, and then sets itself correctly. This keeps the bashrc load time
# small.
# Before the first time `jsonprint` runs, it is an *alias* with the following
# value. After `jsonprint` runs for the first time, either of the following
# situations will occur:
#
# - The reqruied `json.tool` library is not available. The `jsonprint` alias
#   will unset itself and result in a "command not found" error. Afterwards, the
#   `type jsonprint` command will complain that it cannot find the keyword.
# - The `json.tool` library is availabe. The alias replaces itself with a
#   `jsonprint` *function*. Afterwards, the `type jsonprint` command will simply
#   state that it is a simple function.
alias jsonprint='\
if python3 -c "import json.tool" &>/dev/null; then
  jsonprint() { python3 -m json.tool "$@"; }
elif python -c "import json.tool" &>/dev/null; then
  jsonprint() { python -m json.tool "$@"; }
fi
unalias jsonprint; jsonprint '

command -v recap &>/dev/null && alias recap='recap -d "5 hours ago"'

command -v telegram-cli &>/dev/null && alias tg='telegram-cli -l1 -NAW'

# In some distributions https://github.com/sharkdp/fd is installed as `fdfind`.
# Alias that to `fd`.
command -v fdfind &>/dev/null && ! command -v fd &>/dev/null && alias fd=fdfind

# In some distributions https://github.com/sharkdp/bat is installed as
# `batcat`. Alias that to `bat`.
command -v batcat &>/dev/null && ! command -v bat &>/dev/null && alias bat=batcat

# an online snake game
alias tron="ssh sshtron.zachlatta.com"
