" This adds operation mappings for https://github.com/AndrewRadev/linediff.vim.

if !exists(':Linediff')
  echoerr 'Error: https://github.com/AndrewRadev/linediff.vim is required for this plugin.'
  finish
endif

" Mnemonic: Diff Range.
nmap dr <Plug>(operator-marklinediff)
nmap drdr :LinediffReset<CR>
nmap drr :LinediffReset<CR>
vmap Dr <Plug>(operator-marklinediff)

call operator#user#define('marklinediff', 'Op_mark_linediff')
func! Op_mark_linediff(motion_wiseness)
  '[,']Linediff
endfunc
