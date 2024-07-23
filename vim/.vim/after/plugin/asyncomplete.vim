" Don't give `:help inscompletion-mune` messages.
set shortmess+=c

" Required to prevent conflicts between the auto-insertion and the plugin.
let g:asyncomplete_auto_completeopt = 0
set completeopt-=longest
set completeopt+=noinsert
set completeopt+=noselect

" Start suggesting completions after you type three characters.
" This reduces annoyance.
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_min_chars = 3

let g:asyncomplete_preprocessor = [function('asyncomplete#preprocessor#default_preprocessor')]

func! s:register_sources()
  inoremap <C-P> <Plug>(asyncomplete_force_refresh)
  inoremap <C-N> <Plug>(asyncomplete_force_refresh)

  call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
        \ 'name': 'buffer',
        \ 'allowlist': ['*'],
        \ 'completor': function('asyncomplete#sources#buffer#completor'),
        \ 'priority': 1,
        \ }))

  call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
        \ 'name': 'file',
        \ 'allowlist': ['*'],
        \ 'priority': 10,
        \ 'completor': function('asyncomplete#sources#file#completor')
        \ }))

  call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        \ 'name': 'ultisnips',
        \ 'allowlist': ['*'],
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \ }))

  " Dictionary.
  call asyncomplete#register_source({
        \ 'name': 'look',
        \ 'allowlist': ['text', 'markdown'],
        \ 'priority': -10,
        \ 'completor': function('asyncomplete#sources#look#completor'),
        \ })
  call asyncomplete#register_source({
        \ 'name': 'look_good_words',
        \ 'allowlist': ['text', 'markdown'],
        \ 'priority': -10,
        \ 'completor': function('asyncomplete#sources#look#good_words'),
        \ })

endfunc

if has('autocmd')
  augroup register_asyncomplete_sources
    autocmd!
    au User asyncomplete_setup call <SID>register_sources()
  augroup end
endif

" ------------------------------------------------------------
" vim-lsp
" ------------------------------------------------------------

let g:lsp_async_completion = 1
let g:lsp_diagnostics_enabled = 0  " no diagnostic highlights

func! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  " if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gX <plug>(lsp-code-action)
  " nmap <buffer> gs <plug>(lsp-document-symbol-search)
  " nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
  " nmap <buffer> gr <plug>(lsp-references)
  " nmap <buffer> gi <plug>(lsp-implementation)
  " nmap <buffer> gt <plug>(lsp-type-definition)
  " nmap <buffer> <leader>rn <plug>(lsp-rename)
  nmap <buffer> [g <plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g <plug>(lsp-next-diagnostic)
  nmap <buffer> K <plug>(lsp-document-diagnostics)
  " nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
  " nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

  " let g:lsp_format_sync_timeout = 1000
  " autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

  " refer to doc to add more commands
endfunc

if has('autocmd')
  augroup lsp_install
    autocmd!
    " call `s:on_lsp_buffer_enabled`
    " only for languages that has the server registered.
    au User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  augroup end
endif
