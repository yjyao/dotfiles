let $FZF_DEFAULT_OPTS = '--layout=default --info=inline --bind "ctrl-j:ignore,ctrl-k:ignore"'

let g:fzf_preview_window = []  " Disable preview windows.

" Use the <C-p> convention from ctrlp.vim to trigger file search.
nnoremap <C-p> <Cmd>call <SID>fzf(<SID>project_root())<CR>

augroup fzf_window
  autocmd!
  " Fix <C-w> for backward-kill-word.
  au FileType fzf tnoremap <buffer> <c-w> <c-w>.
augroup end

if $FZF_DEFAULT_COMMAND =~ '\<fd\(find\)\?\>'
  let $FZF_DEFAULT_COMMAND .= ' --type f .'
elseif !exists('$FZF_DEFAULT_COMMAND')
  let $FZF_DEFAULT_COMMAND = printf('find -L -type f "!" -path "*/.git/*" "!" -path "*/.jj/*"')
endif

" Use https://github.com/sharkdp/fd if available.
func! s:source_cmd(dir)
  let using_fd = $FZF_DEFAULT_COMMAND =~ '\<fd\(find\)\?\>'
  return using_fd
        \ ? printf($FZF_DEFAULT_COMMAND . ' -x realpath --relative-base "%s" \{\} \; -- "%s"', a:dir, a:dir)
        \ : printf('find -L "%s" -type f "!" -path "*/.git/*" "!" -path "*/.jj/*" -exec realpath --relative-base "%s" \{\} \;', a:dir, a:dir)
endfunc

" Commands used to find project roots.
let g:rooter_commands = ['git root', 'hg root', 'jj root']

func! s:project_root()
  let cmds = join(map(g:rooter_commands, 'v:val . " 2>/dev/null &"'), ' ')
  let root = systemlist(
        \ 'cd ' . expand('%:p:h:S') . '; ' .
        \ cmds . ' ' .
        \ 'wait')
  if !empty(root)
    return root[0]
  endif
  return expand('%:p:h')
endfunc

" Press dash `-` to go up one directory.
func! s:fzf(dir)
  let tf = tempname()
  call writefile(['.'], tf)
  let tf = shellescape(tf)
  call fzf#run(fzf#wrap({
        \ 'dir': a:dir,
        \ 'source':
        \   <SID>source_cmd(shellescape(a:dir)) . ' | ' .
        \   printf('grep -v "$(realpath --relative-base %s %s)"', shellescape(a:dir), expand('%:p:S')),
        \ 'options': [
        \   '--bind',
        \     '-:reload:' .
        \       'cwd="$(cat '.tf.')"; ' .
        \       'base="${cwd}/.."; ' .
        \       'echo "$base" > '.tf.'; ' .
        \       <SID>source_cmd('$base') . ' | ' .
        \       printf('grep -v "$(realpath --relative-base %s %s)"', '"$base"', expand('%:p:S')),
        \  '--bind',
        \    'load:transform-prompt:' .
        \      'printf "%s > " "$(' .
        \        'realpath "$(cat '.tf.')" | ' .
        \        'sed "s:$HOME:~:"' .
        \      ')"',
        \ ]}))
endfunc

" NOTE:
" This currently does not support
" changing directories within the fzf invocation.
" https://github.com/junegunn/fzf.vim/issues/338
" provides workarounds.
" Check it out if interested.
