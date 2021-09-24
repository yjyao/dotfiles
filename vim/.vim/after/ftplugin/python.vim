setlocal tabstop=2 shiftwidth=2

" Enable omnifunc from jedi-vim.
if g:HasPlug('jedi-vim')
  setlocal omnifunc=jedi#completions
endif
