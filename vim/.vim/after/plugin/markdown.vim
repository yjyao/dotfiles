" Note 'java' needs to come *before* 'html':
" See https://vi.stackexchange.com/a/18407.
let g:markdown_fenced_languages = [
      \ 'java',
      \ 'html',
      \ 'python',
      \ 'bash=sh',
      \ 'sql',
      \ 'c',
      \ 'ocaml',
      \ ]
let g:markdown_syntax_conceal = 0
let g:vim_markdown_folding_disabled = 1  " Slows down startup.
