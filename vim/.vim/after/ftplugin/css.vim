setlocal tabstop=2 shiftwidth=2
setlocal tw=0 nowrap

setlocal omnifunc=csscomplete#CompleteCSS

" emmet-vim
if exists('b:has_emmet')
  EmmetInstall
endif
