augroup fswitch
  autocmd!
  " hotkey to goto related file.
  au FileType c,cpp nnoremap <silent> gr <Cmd>FSHere<CR>

  au BufEnter *.cc let b:fswitchdst = 'h,hh'
  au BufEnter *.h let b:fswitchdst = 'c,cc,cpp'
augroup end
