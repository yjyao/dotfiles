" Maybe turn on `g:lexima_ctrlh_as_backspace`?

" Load lexima rules asynchronously
" to cut down vim startup time.
" Calling `lexima#add_rule` forces vim
" to load the lexima scripts at startup time.
call timer_start(20, {t -> <SID>init_lexima_rules()})

func! s:init_lexima_rules()

  " Support breaking Chinese quotation into multiple lines.
  call lexima#add_rule({
        \  'char': '<CR>',
        \  'at': '「\%#」',
        \  'input': '<CR>', 'input_after': '<CR>',
        \ })

  " Strip newlines with a trailing comment (`%`)
  " when doing multi-line brackets
  " in LaTeX.
  call lexima#add_rule({
        \  'char': '<CR>', 'at': '{\%#}',
        \  'input' : '%<CR>', 'input_after': '<CR>',
        \  'filetype' : 'tex',
        \ })
  call lexima#add_rule({
        \  'char': '<CR>', 'at': '\[\%#]',
        \  'input' : '%<CR>', 'input_after': '<CR>',
        \  'filetype' : 'tex',
        \ })
  call lexima#add_rule({
        \  'char': '``',
        \  'input_after': "''",
        \  'filetype' : 'tex',
        \ })

  " Raw string and format strings in python.
  " By default single-quotes following a letter will not auto-pair
  " because of usages like "it's", "Michael's".
  " This rule triggers auto-pair on single-quotes after "r" and "f"
  " for raw strings and format strings like `f'Hello, {name}'`.
  " If necessary, improve by adding "syntax" constraints.
  call lexima#add_rule({
        \  'char': "'",
        \  'at': '[rf]\%#',
        \  'input': "'", 'input_after': "'",
        \  'filetype': 'python',
        \ })

  " Disable `:help lexima-space-rules`
  " for checklists in markdown (`- [ ]`)
  call lexima#add_rule({
        \  'char': ' ',
        \  'at': '[-+*]\s\+[\%#',
        \  'input': ' ',
        \  'filetype': 'markdown',
        \ })

endfunc
