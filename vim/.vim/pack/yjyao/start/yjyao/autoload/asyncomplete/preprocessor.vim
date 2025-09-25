let s:has_matchfuzzypos = exists('*matchfuzzypos')

let s:pair = {
      \  '"':  '"',
      \  '''':  '''',
      \}

function! asyncomplete#preprocessor#default_preprocessor(options, matches) abort
  let l:items = []
  let l:startcols = []
  for [l:source_name, l:matches] in items(a:matches)
    let l:startcol = l:matches['startcol']
    let l:base = a:options['typed'][l:startcol - 1:]
    if has_key(asyncomplete#get_source_info(l:source_name), 'filter')
      let l:result = asyncomplete#get_source_info(l:source_name).filter(l:matches, l:startcol, l:base)
      let l:items += l:result[0]
      let l:startcols += l:result[1]
    else
      if empty(l:base)
        for l:item in l:matches['items']
          call add(l:items, s:strip_pair_characters(l:base, l:item))
          let l:startcols += [l:startcol]
        endfor
      elseif s:has_matchfuzzypos && g:asyncomplete_matchfuzzy
        for l:item in matchfuzzypos(l:matches['items'], l:base, {'key':'word'})[0]
          call add(l:items, s:strip_pair_characters(l:base, l:item))
          let l:startcols += [l:startcol]
        endfor
      else
        for l:item in l:matches['items']
          if stridx(l:item['word'], l:base) == 0
            call add(l:items, s:strip_pair_characters(l:base, l:item))
            let l:startcols += [l:startcol]
          endif
        endfor
      endif
    endif
  endfor

  " Sort matches by priority.
  for [l:source_name, l:matches] in items(a:matches)
    for l:item in l:matches['items']
      let l:item['priority'] =
            \ get(asyncomplete#get_source_info(l:source_name), 'priority', 0)
    endfor
  endfor
  let l:items = sort(l:items, {a, b -> b['priority'] - a['priority']})

  " Strip parens at the end of candidates.
  for l:item in l:items
    let l:item['word'] = substitute(l:item['word'], '()\?$', '', '')
  endfor

  " Strip already entered text.
  let l:line_after_cursor = getline('.')[col('.')-1:]
  let l:word_after_cursor = matchstr(l:line_after_cursor, '^\S\+')
  if !empty(l:word_after_cursor)
    for l:item in l:items
      let l:item['word'] =
            \ l:item['word'][-len(l:word_after_cursor):] ==# l:word_after_cursor ?
            \ l:item['word'][:-len(l:word_after_cursor)-1] : l:item['word']
    endfor
  endif

  let a:options['startcol'] = min(l:startcols)

  call asyncomplete#preprocess_complete(a:options, l:items)
endfunction

function! s:strip_pair_characters(base, item) abort
  " Strip pair characters. If pre-typed text is '"', candidates
  " should have '"' suffix.
  let l:item = a:item
  if has_key(s:pair, a:base[0])
    let [l:lhs, l:rhs, l:str] = [a:base[0], s:pair[a:base[0]], l:item['word']]
    if len(l:str) > 1 && l:str[0] ==# l:lhs && l:str[-1:] ==# l:rhs
      let l:item = extend({}, l:item)
      let l:item['word'] = l:str[:-2]
    endif
  endif
  return l:item
endfunction
