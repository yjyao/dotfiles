" textobj-functioncall
" ----------

" Override function call patterns.
let b:textobj_functioncall_patterns = [
      \ {
      \   'header': '\$',
      \   'bra': '(',
      \   'ket': ')',
      \   'footer': '',
      \ },
      \ ]

" Create new text object for variables.
let b:var_patterns = [
      \ {
      \   'header': '\$',
      \   'bra': '{',
      \   'ket': '}',
      \   'footer': '',
      \ },
      \ ]
onoremap <buffer><silent> iv
      \ :<C-u>call textobj#functioncall#i('o', b:var_patterns)<CR>
xnoremap <buffer><silent> iv
      \ :<C-u>call textobj#functioncall#i('x', b:var_patterns)<CR>
onoremap <buffer><silent> av
      \ :<C-u>call textobj#functioncall#a('o', b:var_patterns)<CR>
xnoremap <buffer><silent> av
      \ :<C-u>call textobj#functioncall#a('x', b:var_patterns)<CR>

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
let b:surround_{char2nr('f')} = "$(\1command: \r..*\r& \1\r)"
let b:surround_{char2nr('F')} = "\"$(\1command: \r..*\r& \1\r)\""
" Quoted/unquoted shell variable.
let b:surround_{char2nr('v')} = "${\r}"
let b:surround_{char2nr('V')} = "\"${\r}\""
