setlocal tw=0 wrap
setlocal linebreak

setlocal spell
syntax spell toplevel  " Don't spellcheck fenced codes/etc.
setlocal complete+=kspell  " Complete English words.

" Recognize filenames in `\include` and `\input`.
let &l:include = '^[^%]*\(\\input\>\|\\include\>\|\\includegraphics\(\[.\{-}\]\)\?\)'
setlocal suffixesadd=.tex

" vim-surround
" ----------

" Quotes
let b:surround_{char2nr('q')} = "`\r'"
let b:surround_{char2nr('Q')} = "``\r''"
" Emphasis
let b:surround_{char2nr('e')} = "\\emph{\r}"
" Math
let b:surround_{char2nr('m')} = "$\r$"
let b:surround_{char2nr('M')} = "\\[\n\t\r\n\\]"
" Pass selection as argument to command.
" Only applies the command if none-empty.
" Example:
"
"  OLD TEXT  COMMAND  INPUT  NEW TEXT
"  hello     ysif     emph   \emph{hello}
"  hello     ysif            hello
let b:surround_{char2nr('f')} = "\1command: \r..*\r\\\\&{\1\r\1\r..*\r}\1"
