" Use `latexmk` to compile LaTeX docs.
" Requires perl.
if !executable('latexmk')
  let g:vimtex_compiler_enabled = 0
endif

let g:vimtex_compiler_latexmk = {
      \ 'continuous' : 0,
      \ 'options' : [
      \   '-xelatex',
      \   '-pdflatex=xelatex',
      \   '-shell-escape',
      \   '-src-specials',
      \   '-synctex=1',
      \   '-interaction=nonstopmode',
      \   '-file-line-error',
      \ ],
      \ }

let g:tex_flavor = 'latex'
let g:tex_indent_items = 0
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_FormatDependency_pdf = 'pdf'
let g:vimtex_view_method = 'general'
let g:vimtex_enabled = 1
let g:vimtex_complete_img_use_tail = 1

" Set PDF viewer with fallbacks.
if executable('SumatraPDF')
  let g:vimtex_view_general_viewer = 'SumatraPDF'
  let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
  let g:vimtex_view_general_options_latexmk = '-reuse-instance'
elseif executable('xdg-open')
  let g:vimtex_view_general_viewer = 'xdg-open'
elseif executable('open')
  let g:vimtex_view_general_viewer = 'open'
else
  let g:vimtex_view_general_viewer = ''
  let g:vimtex_view_enabled = 0
endif

" Use `csd` to toggle these delimiters.
let g:vimtex_delim_toggle_mod_list = [
      \ ['\bigl', '\bigr'],
      \ ['\Bigl', '\Bigr'],
      \ ['\biggl', '\biggr'],
      \ ['\Biggl', '\Biggr'],
      \ ]

let g:vimtex_indent_delims = {
      \ 'open' : ['{', '['],
      \ 'close' : ['}', ']'],
      \ 'close_indented' : 0,
      \ 'include_modified_math' : 1,
      \ }
