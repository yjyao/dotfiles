func! s:wiki_index()
  let roots = join(get(g:, 'waikiki_roots'), ',')
  let index_basename = get(g:, 'waikiki_index', 'index.md')
  return globpath(roots, index_basename, 0, 1)[0]
endf

func! s:wiki_root()
  return fnamemodify(s:wiki_index(), ':h')
endf

func! s:wiki_new_note_path(mod='')
  return fnamemodify(<SID>wiki_root() . '/note-' . strftime('%s') . '.md', a:mod)
endf

com! WikiIndex exec 'edit ' . <SID>wiki_index()
" Creates a new note. Named with the current timestamp.
com! WikiNew exec 'edit ' . <SID>wiki_new_note_path()

let g:waikiki_roots = get(g:, 'waikiki_roots', []) + ['~/notes']
let g:waikiki_default_maps = 0

" Use dashes in place of spaces in filenames.
let g:waikiki_space_replacement = '-'

" Expand the word under cursor with `g:waikiki_word_regex` instead of simple
" <cword> when creating new pages.
let g:waikiki_use_word_regex = 1
let g:waikiki_word_regex = '\(\.\?[-+0-9A-Za-z_]\+\)\+'

" Custom waikiki mappings.
func! s:init_waikiki() abort
  " Use tag-jump hotkeys to navigate through links.
  nmap <buffer> <C-]> <Plug>(waikikiFollowLink)
  vmap <buffer> <C-]> <Plug>(waikikiFollowLink)
  nmap <buffer> <C-w><C-]> <Plug>(waikikiFollowLinkSplit)
  vmap <buffer> <C-w><C-]> <Plug>(waikikiFollowLinkSplit)
  nmap <buffer> <C-t> <Plug>(waikikiGoUp)

  nmap <buffer> ]l <Plug>(waikikiNextLink)
  nmap <buffer> [l <Plug>(waikikiPrevLink)

  " Change "x" marks.
  nmap <buffer> cx <Plug>(waikikiToggleListItem)

  " Inserts a link with a generated file name.
  " Ex: Entering this text ("|" is the cursor):
  "
  "     This is related to [[|
  "
  " The text will expand to:
  "
  "     This is related to [|](note-12315.md)
  "
  inoremap <buffer> [[ [](<C-r>=<SID>wiki_new_note_path(':~:.')<CR>)<C-o>T[

  func! s:fzf()
    return fzf#wrap({
          \ 'source': (executable('rg') ? 'rg' : 'grep -r') . ' --with-filename -e ^ -- ' . <SID>wiki_root(),
          \ 'options': [
          \   '--tac',
          \   '-d', ':',
          \   '--with-nth', '2..',
          \   '--preview', 'cat {1}',
          \   '--bind', 'focus:transform-preview-label:echo [ {1} ]',
          \ ],
          \ 'reducer': { lines -> fnamemodify(      split(lines[0], ':')[0], ':~:.') },
          \ 'sink*':   { lines -> execute('edit ' . split(lines[0], ':')[0]) },
          \ })
  endfunc

  " Enter `((` to insert a note file.
  " This brings up fzf for you to search through all your notes,
  " after selecting a line,
  " the file name will be inserted.
  inoremap <buffer> (( <C-r>=fzf#vim#complete(<SID>fzf())<CR>

  " Since my notes have random file names,
  " jumping between files using file names no longer makes sense.
  " Remap <C-p> to search the note content instead.
  " nnoremap <buffer> <C-p> <Cmd>echom fzf#vim#complete(<SID>fzf())<CR>
  nnoremap <buffer> <C-p> <Cmd>call fzf#run(<SID>fzf())<CR>

  " Conceal/prettify markup characters.
  setlocal conceallevel=2
  setlocal concealcursor=n

  " Do not require capitalized sentences.
  setlocal spellcapcheck=
endfunc

if has('autocmd')
  augroup Waikiki  " Do NOT change! Group name defined by vim-waikiki.
    autocmd!
    au User setup call <SID>init_waikiki()
  augroup end
endif
