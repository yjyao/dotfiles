" Keep the color on after leaving a buffer.
let g:colorizer_disable_bufleave = 1

" The default hex color pattern does not recognize word boundaries properly.
" For example, in `call plugin#add('author/plugin')` in .vimrc,
" the `#add` will be treated as a hex pattern and highlighted.
" This setting overrides the default hex pattern to fix that issue.
"
" The list elements are [prefix, color, suffix].
" -   prefix: word break + '#'
" -   color:  3/6/8 hex digits
" -   suffix: word break
let g:colorizer_hex_pattern = ['\%(\<\|[^[:keyword:]]\)\zs#', '\%(\x\{3}\|\x\{6}\|\x\{8\}\)', '\ze\%([^[:keyword:]]\|\>\)']
