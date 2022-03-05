" Fix rasi.vim's `rasiSectionOpenning` from overriding comments.
syn region rasiMultiLineComment start='/\*' end='\*/' containedin=rasiSectionOpenning
syn match rasiOneLineComment +//.*+ containedin=rasiSectionOpenning

hi def link rasiOneLineComment rasiComment
hi def link rasiMultiLineComment rasiComment
