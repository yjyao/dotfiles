let $FZF_DEFAULT_OPTS = '--layout=default --info=inline --bind "ctrl-j:ignore,ctrl-k:ignore"'

let g:fzf_preview_window = []  " Disable preview windows.

" Use the <C-p> convention from ctrlp.vim to trigger file search.
nnoremap <C-p> <Cmd>call <SID>fzf(expand('%:h'))<CR>

augroup fzf_window
  autocmd!
  " Fix <C-w> for backward-kill-word.
  au FileType fzf tnoremap <buffer> <c-w> <c-w>.
augroup end

" Use https://github.com/sharkdp/fd if available.
func! s:source_cmd(dir)
  if     executable('fd')     | let s:fd_cmd = 'fd'
  elseif executable('fdfind') | let s:fd_cmd = 'fdfind'
  endif
  return exists('s:fd_cmd')
        \ ? printf('%s -Lt f -- . "%s"', s:fd_cmd, a:dir)
        \ : printf('find -L "%s" -type f', a:dir)
endfunc

" Press dash `-` to go up one directory.
func! s:fzf(dir)
  let tf = tempname()
  call writefile(['.'], tf)
  let tf = shellescape(tf)
  call fzf#run(fzf#wrap({
        \ 'dir': a:dir,
        \ 'options': [
        \   '--bind',
        \       '-:reload:cwd="$(cat '.tf.')"; ' .
        \       'base="${cwd}/.."; ' .
        \       'echo "$base" > '.tf.'; ' .
        \       s:source_cmd('$base'),
        \ ]}))
endfunc

" NOTE:
" This currently does not support
" changing directories within the fzf invocation.
" https://github.com/junegunn/fzf.vim/issues/338
" provides workarounds.
" Check it out if interested.
