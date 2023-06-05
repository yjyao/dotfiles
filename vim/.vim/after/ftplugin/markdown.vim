setlocal tw=0
setlocal linebreak

setlocal spell
syntax spell toplevel  " Don't spellcheck fenced codes/etc.
setlocal complete+=kspell  " Complete English words.

setlocal omnifunc=htmlcomplete#CompleteTags

" text objects
" ----------

func! s:SectionHeadingRegex(is_inner)
  " "a section" includes the heading; "inner section" excludes the heading.
  " For two-line section headings,
  " land the cursor on the first line to include the entire heading for "a section",
  " but on the second/last line so we can exclude the heading when we skip to the next line for "inner section".
  return '^#\{1,5\}\s\+\S\|^\S.*\n' . (a:is_inner ? '\zs' : '') . '[=-]\+$'
endfunc
func! s:SectionTextObject(is_inner)
  " The heading for the next section should never be included.
  call aroundobj#create(s:SectionHeadingRegex(a:is_inner), s:SectionHeadingRegex(0), (a:is_inner ? 1 : 0),  -1)
endfunc
vnoremap <buffer> <silent> aS :<C-u>call <SID>SectionTextObject(0)<CR>
onoremap <buffer> <silent> aS :normal VaS<CR>
vnoremap <buffer> <silent> iS :<C-u>call <SID>SectionTextObject(1)<CR>
onoremap <buffer> <silent> iS :normal ViS<CR>

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
