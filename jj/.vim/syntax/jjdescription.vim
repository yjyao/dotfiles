" \C - Always match case. Only treat uppercase "JJ" as comment marker.
syn match JjdescriptionOneLineComment /\C^JJ: .*/ contains=JjdescriptionFileAdd,JjdescriptionFileChange,JjdescriptionFileDelete
syn match JjdescriptionFileAdd /\C^JJ:\s\+\zsA\>/ contained
syn match JjdescriptionFileChange /\C^JJ:\s\+\zsM\>/ contained
syn match JjdescriptionFileDelete /\C^JJ:\s\+\zsD\>/ contained

hi def link JjdescriptionOneLineComment Comment
hi def link JjdescriptionFileAdd DiffAdd
hi def link JjdescriptionFileChange DiffChange
hi def link JjdescriptionFileDelete DiffDelete
