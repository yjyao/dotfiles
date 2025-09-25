" mnemonic: "function [C]all"
xmap ic <Plug>(textobj-functioncall-i)
omap ic <Plug>(textobj-functioncall-i)
xmap ac <Plug>(textobj-functioncall-a)
omap ac <Plug>(textobj-functioncall-a)

let g:textobj_functioncall_patterns = [
      \ {
      \   'header': '\<\h\k*\%(\_s*\%(\.\|->\|::\)\_s*\h\k*\)*',
      \   'bra': '(',
      \   'ket': ')',
      \   'footer': '',
      \ },
      \ {
      \   'header': '\<\h\k*\%(\_s*\%(\.\|->\|::\)\_s*\h\k*\)*',
      \   'bra': '\[',
      \   'ket': '\]',
      \   'footer': '',
      \ },
      \ ]
