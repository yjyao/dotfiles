" Also enable limelight (dims paragraphs other than the current one)
" when entering goyo mode.
func! s:goyo_enter()
  set scrolloff=999
  set relativenumber
  Limelight
endfunc

func! s:goyo_leave()
  Limelight!
endfunc

augroup goyo_settings
  autocmd!
  au User GoyoEnter nested call <SID>goyo_enter()
  au User GoyoLeave nested call <SID>goyo_leave()
augroup end
