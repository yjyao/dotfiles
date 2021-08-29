setlocal tabstop=2 shiftwidth=2

" Enable omnifunc from jedi-vim.
if exists('b:has_jedi')
  setlocal omnifunc=jedi#completions
endif
