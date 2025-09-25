if has('autocmd')
  augroup targets
    autocmd!
    au User targets#mappings#user call targets#mappings#extend({
          \ 'b': {'pair': [{'o':'(', 'c':')'}]}
          \ })
  augroup end
endif
let g:targets_nl = ['n', 'N']
" Only seek if next/last targets touch current line.
let g:targets_seekRanges = 'cr cb cB lc ac Ac lr rr ll lb ar ab lB Ar aB Ab AB rb rB al Al'
