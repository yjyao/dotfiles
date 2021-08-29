vnoremap <buffer> <silent> aS :<C-U>call aroundobj#create('^---', '^---', 1,  0)<CR>
onoremap <buffer> <silent> aS :<C-U>call aroundobj#create('^---', '^---', 1,  0)<CR>
vnoremap <buffer> <silent> iS :<C-U>call aroundobj#create('^---', '^---', 1, -1)<CR>
onoremap <buffer> <silent> iS :<C-U>call aroundobj#create('^---', '^---', 1, -1)<CR>
nnoremap <buffer> <silent> [{ :call search('^---', 'bW')<CR>
nnoremap <buffer> <silent> ]} :call search('^---', 'W')<CR>
