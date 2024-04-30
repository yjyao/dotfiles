" Use <Leader>[wbe] to move around
" in CamelCase and snake_case words.
" Also supports text object so one can ci<Leader>w

nmap <silent> <Leader>w  <Plug>CamelCaseMotion_w
nmap <silent> <Leader>b  <Plug>CamelCaseMotion_b
nmap <silent> <Leader>e  <Plug>CamelCaseMotion_e
nmap <silent> <Leader>ge <Plug>CamelCaseMotion_ge

" CamelCase/snake_case text objects
omap <silent> i<Leader>w <Plug>CamelCaseMotion_ie
xmap <silent> i<Leader>w <Plug>CamelCaseMotion_ie
omap <silent> a<Leader>w <Plug>CamelCaseMotion_iw
xmap <silent> a<Leader>w <Plug>CamelCaseMotion_iw
