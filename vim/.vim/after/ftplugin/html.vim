setlocal tabstop=2 shiftwidth=2
setlocal tw=0 nowrap

setlocal omnifunc=htmlcomplete#CompleteTags

" Requires emmet-vim.
if exists(':EmmetInstall')
  EmmetInstall
endif
