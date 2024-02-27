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

" Tables
" ----------

inoremap <buffer><silent> <Bar>   <Bar><C-o>:call <SID>align()<CR>

" Stolen and modified from https://gist.github.com/tpope/287147.
" Modifications:
" - Uses https://github.com/junegunn/vim-easy-align
"   instead of https://github.com/godlygeek/tabular.
" - Operates on a paragraph level.
"   The entire paragraph that the cursor is in must fulfill:
"   - Has a markdown table header line (e.g., `--- | :--- | ---`)
"   - Every line in the paragraph has columns separated by bars (`|`)
function! s:align()
  if !exists(':EasyAlign') | return | endif
  let has_table_header = search(':\?-\+:\?\s*|\s*:\?-\+:\?', 'bcnp', line("'{")) > 0
  let all_lines_in_paragraph_have_columns
        \ =  search('^\(\s*[^|[:space:]]\+\s*\)\+$', 'bcnp', line("'{")) == 0
        \ && search('^\(\s*[^|[:space:]]\+\s*\)\+$',  'cnp', line("'}")) == 0
  let is_paragragh_a_table = has_table_header && all_lines_in_paragraph_have_columns
  if !is_paragragh_a_table | return | endif
  let line=line(".")
  let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
  let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
  '{,'}EasyAlign *|
  call cursor(line, 0)
  call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'), 'e+1')
endfunction
