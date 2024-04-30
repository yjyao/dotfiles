" vim-surround
" ----------

" Function.
" Cleverly omits spaces.
" Example:
"
"  OLD TEXT  COMMAND  INPUT     NEW TEXT
"  "hello"   ysif     format t  (format t "hello")
"  func      ysif               (func)
let b:surround_{char2nr('f')} = "(\1function: \r..*\r& \1\r)"
