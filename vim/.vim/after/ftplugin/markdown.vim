setlocal tw=0 wrap
setlocal linebreak

setlocal spell
syntax spell toplevel  " Don't spellcheck fenced codes/etc.
setlocal complete+=kspell  " Complete English words.

setlocal omnifunc=htmlcomplete#CompleteTags

" vim-surround
" ----------

" Emphasis
let g:surround_{char2nr('e')} = "*\r*"
let g:surround_{char2nr('E')} = "**\r**"
" Strikethru
let g:surround_{char2nr('s')} = "~~\r~~"
" URL/link
let g:surround_{char2nr('u')} = "[\r](\1url: \1)"
let g:surround_{char2nr('U')} = "[\1label: \1](\r)"
" Math
let g:surround_{char2nr('m')} = "$\r$"
let g:surround_{char2nr('M')} = "\\[\n\t\r\n\\]"
" Code fences
let g:surround_{char2nr('c')} = "```\1language: \1\n\r\n```"
