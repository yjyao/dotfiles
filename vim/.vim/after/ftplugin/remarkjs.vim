vnoremap <buffer> <silent> aS :<C-U>call <SID>AroundLinesTextObj('^---', '^---', 1,  0)<CR>|
onoremap <buffer> <silent> aS :<C-U>call <SID>AroundLinesTextObj('^---', '^---', 1,  0)<CR>|
vnoremap <buffer> <silent> iS :<C-U>call <SID>AroundLinesTextObj('^---', '^---', 1, -1)<CR>|
onoremap <buffer> <silent> iS :<C-U>call <SID>AroundLinesTextObj('^---', '^---', 1, -1)<CR>|
nnoremap <buffer> <silent> [{ :call search('^---', 'bW')<CR>|
nnoremap <buffer> <silent> ]} :call search('^---', 'W')<CR>

" Defines a text object that selects a block of text where the begine and end
" patterns surround the cursor.
func! s:AroundLinesTextObj(pattern_begin, pattern_end, offset_begin, offset_end) abort
  " Args:
  "   pattern_begin, pattern_end: patterns that surround the object. searchs up
  "   for begin, down for end.
  "   offset_begin, offset_end: number of lines to offset the selection.

  " Move the cursor to the end of line in case that cursor is on the opening
  " of a code block. Actually, there are still issues if the cursor is on the
  " closing of a code block. In this case, the start row of code blocks would
  " be wrong. Unless we can match code blocks, it is not easy to fix this.
  normal! $
  let start_row = searchpos(a:pattern_begin, 'bnW')[0]
  let end_row = searchpos(a:pattern_end, 'nW')[0]
  let start_row += a:offset_begin
  let end_row += a:offset_end

  let buf_num = bufnr()
  call setpos("'<", [buf_num, start_row, 1, 0])
  call setpos("'>", [buf_num, end_row, 1, 0])
  execute 'normal! `<V`>'
endfunc
