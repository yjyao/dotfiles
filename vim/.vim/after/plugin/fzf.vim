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
  let cmd = using_fd
        \ ? printf($FZF_DEFAULT_COMMAND . ' -x realpath --relative-base %s \{\} \; -- %s', a:dir, a:dir)
        \ : printf('find -L %s -type f "!" -path "*/.git/*" "!" -path "*/.jj/*" -exec realpath --relative-base %s \{\} \;', a:dir, a:dir)
  echom '$ ' . cmd
  return cmd
endfunc

" Commands used to find project roots.
if !exists('g:rooter_commands')
  let g:rooter_commands = g:default_rooter_commands
endif

func! s:project_root()
  for cmd in g:rooter_commands
    let root = systemlist('cd ' . expand('%:p:h:S') . '; '. cmd . ' 2>/dev/null')
    echom 'hey ' . cmd
    echom root
    if !empty(root)
      return root[0]
    endif
  endfor
  return expand('%:p:h')
endfunc

func! s:edit_files_relative_to_path(...)
  let root = readfile(a:1)[0]
  exec 'edit ' . simplify(root . '/' . a:2)
endfunc

" Press dash `-` to go up one directory.
func! s:fzf(dir)
  let cwd_f = tempname()
  call writefile([a:dir], cwd_f)
  let cwd = shellescape(cwd_f)
  call fzf#run(fzf#wrap({
        \ 'dir': a:dir,
        \ 'sink': function(expand('<SID>').'edit_files_relative_to_path', [cwd_f]),
        \ 'options': [
        \   '--bind',
        \     '-:reload:' .
        \       'cwd="$(cat '.cwd.')"; ' .
        \       'cwd="${cwd}/.."; ' .
        \       'echo "$cwd" > '.cwd.'; ' .
        \       <SID>source_cmd('"$cwd"') . ' | ' .
        \       printf('grep -v "$(realpath --relative-base %s %s)"', '"$cwd"', expand('%:p:S')),
        \  '--bind',
        \    'load:transform-prompt:' .
        \      'printf "%s > " "$(' .
        \        'realpath "$(cat '.cwd.')" | ' .
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
