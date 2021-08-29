" vim-surround
" ----------

" Quoted/unquoted subshell command.
" Cleverly omits spaces.
" Example:
"
"  OLD TEXT  COMMAND  INPUT  NEW TEXT
"  hello     ysif     echo   $(echo hello)
"  hello     ysif            $(hello)
"  hello     ysiF     echo   "$(echo hello)"
"  hello     ysiF            "$(hello)"
let g:surround_{char2nr('f')} = "$(\1command: \r..*\r& \1\r)"
let g:surround_{char2nr('F')} = '"$(\1command: \r..*\r& \1\r)"'
" Quoted/unquoted shell variable.
let g:surround_{char2nr('v')} = "${\r}"
let g:surround_{char2nr('V')} = '"${\r}"'
