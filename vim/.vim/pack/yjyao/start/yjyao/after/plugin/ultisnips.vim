" Trigger configuration.
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
inoremap <C-j> <C-o>:echo 'Not in a snippet'<CR>
inoremap <C-k> <C-o>:echo 'Not in a snippet'<CR>

let g:UltiSnipsEditSplit = 'vertical'

let g:UltiSnipsSnippetsDir = g:vimfiles_dir . '/UltiSnips'

" Set quoting style in python.snippets provided by vim-snippets.
let g:ultisnips_python_quoting_style = 'single'

" List all snippets.
inoremap <C-l> <Esc>:Snippets<CR>
com! Snippets :call GetAllSnippets()
" https://stackoverflow.com/questions/58081390/why-doesnt-ultisnips-listing-of-available-snippets-work#tab-top
func! GetAllSnippets()
  call UltiSnips#SnippetsInCurrentScope(1)
  let list = []
  for [key, info] in items(g:current_ulti_dict_info)
    let parts = split(info.location, ':')
    call add(list, {
          \ 'text': key,
          \ 'filename': parts[0],
          \ 'lnum': parts[1],
          \ 'context': info.description,
          \ })
  endfor
  call setqflist([], ' ', { 'title': 'Snippets', 'items' : list})

  " Open Quickfix list as soon as it is populated.
  cwindow
endfunc
