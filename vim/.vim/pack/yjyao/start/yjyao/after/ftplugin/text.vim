setlocal tabstop=8 shiftwidth=8
setlocal wrap
setlocal linebreak

setlocal spell
syntax spell toplevel  " Don't spellcheck fenced codes/etc.
setlocal complete+=kspell  " Complete English words.

" Better recognize lists.
setlocal formatlistpat=^\\s*[\\[({]\\\?\\([0-9]\\+\\\|[iIvVxXlLcCdDmM]\\+\\\|[a-zA-Z]\\)[\\]:.)}]\\s\\+\\\|^\\s*[-+o*]\\s\\+
setlocal formatoptions+=n
