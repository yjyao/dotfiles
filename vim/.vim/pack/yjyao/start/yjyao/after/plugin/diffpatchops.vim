" diffpatch yes (y)
nmap dy <Plug>(operator-usediffpatch)
nmap dydy <Plug>(operator-usediffpatch)l
nmap dyy <Plug>(operator-usediffpatch)l
vmap Dy <Plug>(operator-usediffpatch)
call operator#user#define('usediffpatch', 'Op_use_diff_patch')
func! Op_use_diff_patch(motion_wiseness)
  '[,']s/^ //e
  '[,']s/^+\ze //e
  " By removing lines, this changes the '[ and '] markers!
  '[,']g/^- /d_
endfunc

" diffpatch no (X)
nmap dx <Plug>(operator-invertdiffpatch)
nmap dxdx <Plug>(operator-invertdiffpatch)l
nmap dxx <Plug>(operator-invertdiffpatch)l
vmap Dx <Plug>(operator-invertdiffpatch)
call operator#user#define('invertdiffpatch', 'Op_invert_diff_patch')
func! Op_invert_diff_patch(motion_wiseness)
  '[,']s/^ //e
  '[,']s/^-\ze //e
  " By removing lines, this changes the '[ and '] markers!
  '[,']g/^+ /d_
endfunc

" " Vanilla implementation without vim-operator-user.

" nnoremap <silent> du :set opfunc=UseDiffPatch<CR>g@
" nnoremap <silent> duu :set opfunc=UseDiffPatch<CR>g@l
" nnoremap <silent> di :set opfunc=InvertDiffPatch<CR>g@
" nnoremap <silent> dii :set opfunc=InvertDiffPatch<CR>g@l

" func! UseDiffPatch(txtobj_type)
"   '[,']s/^ //e
"   '[,']s/^+\ze //e
"   " By removing lines, this changes the '[ and '] markers!
"   '[,']g/^- /d_
" endfunc

" func! InvertDiffPatch(txtobj_type)
"   '[,']s/^ //e
"   '[,']s/^-\ze //e
"   " By removing lines, this changes the '[ and '] markers!
"   '[,']g/^+ /d_
" endfunc
