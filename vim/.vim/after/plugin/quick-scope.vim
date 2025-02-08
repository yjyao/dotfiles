" Break words to highlight even by underscores.
for motion in split('fFtT', '\zs')
  " Using <expr> for normal mode mappings can cause problems (#80).
  execute printf('
        \   nnoremap <silent> <Plug>(MoreQuickScope%s) :<C-U>call quick_scope#Ready() \|
        \   let oldiskeyword = &l:iskeyword \|
        \   setlocal isk=65-90,97-122 \|
        \   execute "normal!" v:count1 . quick_scope#Aim("%s") \|
        \   call quick_scope#Reload() \|
        \   call quick_scope#DoubleTap() \|
        \   :let &l:iskeyword = oldiskeyword<CR>',
        \ motion, motion)
endfor
for motion in filter(g:qs_highlight_on_keys, "v:val =~# '^[fFtT]$'")
  execute printf('nmap %s <Plug>(MoreQuickScope%s)', motion, motion)
endfor

" Underline candidates.
" The candidate highlights can blend with syntax highlights.
" Adding underlines to them can help with identifying them.
func! s:set_quick_scope_highlights()
  highlight QuickScopePrimary   guifg='#40ffff' gui=underline ctermfg=4 cterm=underline
  highlight QuickScopeSecondary guifg='#ff80ff' gui=underline ctermfg=9 cterm=underline
endfunc
call <SID>set_quick_scope_highlights()
augroup qs_colors
  autocmd!
  au ColorScheme * call <SID>set_quick_scope_highlights()
augroup end
