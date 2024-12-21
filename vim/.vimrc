" 辅助变量配置
" ========================================================================= {{{
let g:iswindows = 0
let g:islinux = 0
if has('win32') || has('win64') || has('win95') || has('win16')
  let g:iswindows = 1
  let g:vimrc_dir='$vim'
  let g:vimfiles_dir='$vimfiles'
  let g:vimrc_path='$vim/_vimrc'
else
  let g:islinux = 1
  let g:vimrc_dir='~'
  let g:vimfiles_dir='~/.vim'
  let g:vimrc_path='~/.vimrc'
endif

let g:isGUI = 0
if has('gui_running')
  let g:isGUI = 1
endif

" ========================================================================= }}}
" Global helper functions
" ========================================================================= {{{

func! SystemNoNull(cmd)
  return substitute(system(a:cmd), '\n', '', 'g')
endfunc

" ========================================================================= }}}
" Built-in optional packages
" ========================================================================= {{{

packadd! matchit  " More pair match patterns for `%`.
packadd! cfilter  " Filter quicklist.

" ========================================================================= }}}
" Packager - Plugin Installer
" ========================================================================= {{{
" https://github.com/kristijanhusak/vim-packager

" TIP: To install all plugins on a clean machine, run
"     $ vim --clean '+source ~/.vimrc' +PlugUpdate '+qall!'

exec 'set packpath^='.g:vimfiles_dir
func! s:get_packager() abort
  if !empty(globpath(&packpath, '/pack/*/opt/vim-packager'))
    return
  endif
  " Download vim-packager into the first directory in `&packpath`.
  let best_packpath = substitute(&packpath, ',.*', '', '')
  call system(
        \ 'git clone '.
        \ 'https://github.com/kristijanhusak/vim-packager '.
        \ best_packpath.'/pack/packager/opt/vim-packager')
endfunc
func! s:packager_init() abort
  call <SID>get_packager()
  packadd vim-packager
  " Add the package manager itself
  " so that `:PlugClean` won't clean it.
  call packager#add('kristijanhusak/vim-packager', {'type': 'opt'})

  " plugin-list#begin

  " Benchmark vim startup time. (Fancier `vi --startuptime`.)
  call packager#add('dstein64/vim-startuptime', {'type': 'opt'})

  " Snippet triggering system.
  call packager#add('SirVer/ultisnips')
  " Provides many snippets.
  call packager#add('honza/vim-snippets')

  " Auto-complete family.

  call packager#add('hiterm/asyncomplete-look') " Dictionary completion.
  call packager#add('prabirshrestha/asyncomplete-file.vim')
  call packager#add('prabirshrestha/asyncomplete-lsp.vim')
  call packager#add('prabirshrestha/asyncomplete-ultisnips.vim')
  call packager#add('prabirshrestha/vim-lsp')
  call packager#add('yjyao/asyncomplete-buffer.vim')
  call packager#add('yjyao/asyncomplete.vim')

  call packager#add('kana/vim-operator-user')

  " Vim operators:
  " - `gJ` to split one-liner code.
  " - `gK` to join code blocks into one-liners.
  call packager#add('AndrewRadev/splitjoin.vim')
  " No need to `:set paste` before pasting from terminal.
  call packager#add('ConradIrwin/vim-bracketed-paste')
  " Quickly create consecutive numbers.
  call packager#add('JikkuJose/vim-visincr')
  call packager#add('Vimjas/vim-python-pep8-indent')
  call packager#add('chaoren/vim-wordmotion')
  call packager#add('chrisbra/Colorizer')
  " Vim operator that sorts lines.
  call packager#add('christoomey/vim-sort-motion')
  call packager#add('christoomey/vim-tmux-navigator')
  call packager#add('cohama/lexima.vim') " Auto pair closer
  " Jump between header/implementation files.
  call packager#add('derekwyatt/vim-fswitch')
  " Wiki system: Link and tag handling.
  call packager#add('fcpg/vim-waikiki')
  call packager#add('junegunn/fzf') " fuzzy finder
  call packager#add('junegunn/fzf.vim') " fuzzy finder extended
  call packager#add('junegunn/vim-easy-align')
  call packager#add('lervag/vimtex') " LaTeX utils.
  call packager#add('lifepillar/vim-solarized8') " Colorscheme.
  call packager#add('machakann/vim-textobj-functioncall')
  " https://emmet.io: fast HTML creation.
  call packager#add('mattn/emmet-vim')
  call packager#add('michaeljsmith/vim-indent-object')
  call packager#add('powerman/vim-plugin-AnsiEsc')
  " Character-level diff.
  call packager#add('rickhowe/diffchar.vim', { 'commit': '0187321' })
  " Auto disable search highlights.
  call packager#add('romainl/vim-cool')
  call packager#add('takac/vim-hardtime') " Stop bad habbits.
  " Vim operator for exchanging/swapping text.
  call packager#add('tommcdo/vim-exchange')
  " Vim operator that comments code.
  call packager#add('tpope/vim-commentary')
  call packager#add('tpope/vim-markdown')
  " Make `.` repeat some plugin motions.
  call packager#add('tpope/vim-repeat')
  " Vim operator that surronds text objects with parens/etc.
  call packager#add('tpope/vim-surround')
  " Highlight cues for `f` and `t`.
  call packager#add('unblevable/quick-scope')
  " Close HTML tags with <C-BS>.
  call packager#add('vim-scripts/closetag.vim')
  " Pin the first line of each indentation level as reference.
  call packager#add('wellle/context.vim')
  " Objects like arg, search-ahaed paren-objects.
  call packager#add('wellle/targets.vim')
  " Consolidate conflict markers into 2-pane diff.
  call packager#add('whiteinge/diffconflicts')
  " Diff directories.
  call packager#add('will133/vim-dirdiff')
  " Support filepath:line:col syntax.
  call packager#add('wsdjeg/vim-fetch')
  call packager#add('yjyao/recap.vim')

  " Extends <c-a>/<c-x>, load BEFORE speeddating.
  call packager#add('tenfyzhong/axring.vim')
  " Extends <c-a>/<c-x> to work with dates.
  call packager#add('tpope/vim-speeddating')

  " Focus writing mode. Goes with limelight.vim.
  call packager#add('junegunn/goyo.vim')
  " Highlight current paragraph.
  call packager#add('junegunn/limelight.vim')

  doautocmd User InitPackager

  " plugin-list#end
endfunc
com! -nargs=* -bar PlugInstall call s:packager_init() | call packager#install(<args>)
com! -nargs=* -bar PlugUpdate  call s:packager_init() | call packager#update(<args>)
com! -bar PlugClean  call s:packager_init() | call packager#clean()
com! -bar PlugStatus call s:packager_init() | call packager#status()

" Sort `packager#add` lines
" within their own blocks
" while keeping empty lines and comment lines.
func! s:sort_plugins() abort
  let pos = getpos('.')
  let oldfoldenable = &foldenable
  setlocal nofoldenable
  " Mark all linebreaks with "§BR§".
  1/plugin-list#begin/,1/plugin-list#end/ s/$/§BR§/g
  1/plugin-list#end/ | let end = line('.')
  1/plugin-list#begin/
  while search('^§BR§$', 'W', end) > 0
    let blockend = search('^§BR§$', 'nW', end) - 1
    if blockend <= 0 | break | endif
    " Mark begin and end of block.
    exec line('.') . 's/^/§BOB§/'
    exec blockend  . 's/^/§EOB§/'
    " Join all comment or continuation lines.
    1/§BOB§/,1/§EOB§/ s/^\s*["\\]\s.*\zs\n//e
    1/§BOB§/,1/§EOB§/ sort /.*packager#add/
    " Remove the block marks.
    1/plugin-list#begin/,1/plugin-list#end/ s/§BOB§\|§EOB§//ge
  endwhile
  " Restore the linebreaks.
  1/plugin-list#begin/,1/plugin-list#end/ s/§BR§\n\?/\r/ge
  call setpos('.', pos)
  let &foldenable = oldfoldenable
endfunc

" Always keep the plugin list sorted.
if has('autocmd')
  augroup sort_plugins
    autocmd!
    au BufWritePre .vimrc silent call <SID>sort_plugins()
  augroup end
endif

" ========================================================================= }}}
" 界面配置
" ========================================================================= {{{

" 设置消息精简程度
set shortmess=atI

if g:isGUI
  " 设置菜单界面
  set guioptions=                     " 完全取消菜单界面

  " 设置 gVim 窗口初始位置及大小
  winpos 0 0                          " 指定窗口出现的位置，坐标原点在屏幕左上角
  set lines=38 columns=100            " 指定窗口大小，lines为高度，columns为宽度

  " 设定默认字体
  let g:guifont = 'Consolas'
  let g:guifontwide = 'FZLanTingHeiS-EL-GB'
  let g:guifontwide = 'YaHei_Consolas_Hybrid'
  let g:guifontsize = 12
  " 提供改变字号的函数
  func! SetGuiFontSize(s)
    if g:iswindows
      exec 'set guifont=' . g:guifont . ':h' . string(a:s)
      exec 'set guifontwide=' . g:guifontwide . ':h' . string(a:s)
    else
      exec 'set guifont=' . g:guifont . '\ ' . string(a:s)
      exec 'set guifontwide=' . g:guifontwide . '\ ' . string(a:s-0.5)
    endif
    let g:guifontsize = a:s
  endfunc
  " 默认 10.5 号字
  call SetGuiFontSize(10.5)
endif

" 光标移动到 buffer 的顶部和底部时保持 3 行距离
set scrolloff=3
" 横向滚动
set sidescroll=1
set sidescrolloff=3

" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\

" 状态行
set statusline=
"set statusline+=%2*%-3.3n%0*    " buffer number
set statusline+=%f\              " file name
set statusline+=%m%r%h%w         " flag. [+] for changed/unsaved
set statusline+=[%{&encoding}]   " encoding
set statusline+=[%{&fileformat}] " encoding
set statusline+=[POS=%l,%v]      " position
set statusline+=[%p%%]           " percentage of file
set statusline+=%=               " right align
set statusline+=%{strftime(\"%m/%d/%y\ -\ %H:%M\")}\  " time
" 总是显示状态行
set laststatus=2

" 命令行的高度
set cmdheight=2

" 总是显示标签栏
" set showtabline=2

" 当缓冲区被丢弃的时候隐藏它
set bufhidden=hide

" 字符间插入的像素行数目
set linespace=0

" 显示行号
set number
" 显示相对当前行的行号
set relativenumber

" 高亮搜索结果
set hls

" ========================================================================= }}}
" 核心设置
" ========================================================================= {{{

" 不要备份文件
set nobackup

" 不要生成 swap 文件
set noswapfile

" 临时文件的位置。在 windows 下默认位置需要管理员权限。绕开
if g:iswindows
  let $TMP = g:vimfiles_dir . '\tmp'
else
  let $TMP = '/tmp/'
endif

" 文本修改记录
set undofile
set undodir=$TMP

" cmd line 中的命令数记录
set history=100

" 在处理未保存或只读文件的时候，弹出确认
set confirm

" 使用系统剪贴板
set clipboard=unnamed,unnamedplus

" 保存全局变量
set viminfo+=!

" 命令行模式下补全、模糊大小写
set wildmenu
set wildignorecase fileignorecase
set wildoptions+=fuzzy

" 每次命令行命令后告诉我们共更改了文件多少行内容
" 如 :s 之后会得到如 "3 substitutions on 1 line" 的提示
set report=0

" mswin 下 visual 改成了 exclusive 。恢复默认
set selection=inclusive

" Load help files under doc/
if !empty(glob(g:vimfiles_dir . '/doc/*'))
  exec 'helptags ' . g:vimfiles_dir . '/doc'
endif

" chinese input
" 需要编译时打开 +xim, +multi_byte_ime 或 global-ime 特性版本的 Vim
set noimcmdline
set imsearch=0 iminsert=0
if has('autocmd')
  augroup chinese_input
    autocmd!
    au InsertLeave * set iminsert=0 imsearch=0
    au CursorMoved * set iminsert=0 imsearch=0
  augroup end
endif

" faster grep programs
if executable('rg')
  set grepprg=rg\ -L\ --hidden\ --vimgrep\ --no-heading\ --color=never\ -g='!%'
elseif executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

" 必要时重新生成 spl 拼写检查库
for d in glob(g:vimfiles_dir . '/spell/*.add', 1, 1)
  if filereadable(d) && (!filereadable(d . '.spl') ||
        \ getftime(d) > getftime(d . '.spl'))
    exec 'silent mkspell! ' . fnameescape(d)
  endif
endfor

" Do not treat numbers with a leading zero (`03`) as octal
" when increasing/decreasing it with <C-a>/<C-x>.
set nrformats-=octal

" Trigger focus-events on terminal.
let &t_fe = "\<Esc>[?1004h"
let &t_fd = "\<Esc>[?1004l"
exec "set <FocusGained>=\<Esc>[I"
exec "set <FocusLost>=\<Esc>[O"

" ========================================================================= }}}
" 操作
" ========================================================================= {{{

" 不要使用 vi 的键盘模式，而是 vim 的
set nocompatible

" 设置 leader 健
let mapleader = "\<Space>"
let maplocalleader = mapleader

" Disable ex-mode hotkey. Use `gQ` if you really mean it.
nnoremap Q <nop>

" 保存
" nnoremap <C-s> :update<CR>
" inoremap <C-s> <Esc>:update<CR>
nnoremap <Leader>s :update<CR>

" 使用 kj / Ctrl-c 退出到命令模式（同 Esc）
imap kj <Esc>
imap <C-c> <Esc>

" Emacs mode <Home>/<End> keys in insert mode.
inoremap <C-a> <Home>
inoremap <C-e> <End>

noremap gl $
noremap gh ^

" 搜索并落在结果的最后。用于和其他操作配合
" `df<char>` 或 `cf<char>` 往往不够精准。需要数一下目标是第几个 `<char>`。这时
" 候 `d/<pattern><CR>` 则方便得多（有高亮辅助。准确定位）
" 但是有时我们更倾向于搜索到要操作部分的结尾。而非下一个词的开头。试比较
"   Lorem [i]psum dolor sit amet, consectetur adipiscing elit.
" 要删至 sit （含）。用 `/` 搜索则需要从之后的空格开始搜索。这不符合直觉。此时
" 我们倾向于使用 `d/sit/e`。此映射省去了输入 "/e" 的步骤。
onoremap <silent> g/ //e<Left><Left>

" 开关比对模式 (diffthis/diffoff)
nmap dm :if &diff \| diffoff \| else \| diffthis \| endif<CR>

" 更新比对结果 (diff update)
nmap du :diffupdate<CR>

" 查看改动了什么（diff changes）
" TODO: Compare this against `:help :DiffOrig`
nmap dc :w !git diff `readlink %` -<CR>

" 快速开关选项
" 拼写检查 (change option spell)
nmap cos :call ToggleSetting('spell')<CR>
" 高亮搜索结果 (change option highlightsearch)
nmap coh :call ToggleSetting('hls')<CR>
" 粘贴模式 (change option paste)
nmap cop :call ToggleSetting('paste')<CR>
" 折行 (change option wrap)
nmap cow :call ToggleSetting('wrap')<CR>
" change option cursorline
nmap coc :call ToggleSetting('cursorline')<CR>
" change option cursorCROSS (turns both `cursorline` and `cursorcolumn` on/off)
nmap cox :call ToggleCursorCross()<CR>
" 比对时空格敏感 (change option diff whitespace)
nmap codw :call ToggleDiffopt('iwhite')<CR>
" 比对时大小写敏感 (change option diff case)
nmap codc :call ToggleDiffopt('icase')<CR>

func! ToggleSetting(setting)
  exec 'set '.a:setting.'!'
  exec 'set '.a:setting.'?'
endfunc

func! ToggleDiffopt(opt)
  if &diffopt =~ a:opt
    exec 'set dip-='.a:opt
  else
    exec 'set dip+='.a:opt
  endif
  echo &diffopt
endfunc

func! ToggleCursorCross()
  if &cursorline && &cursorcolumn
    set nocursorline nocursorcolumn
  else
    set cursorline cursorcolumn
  endif
endfunc

" change vimrc
exec 'nmap crc :tabnew ' . g:vimrc_path . '<CR>'

" config update
exec 'nmap cu :source ' . g:vimrc_path . '<CR>'

" 在命令行下使用 ctrl-v 粘贴
cmap <C-v> <C-r>+

" Emacs mode <Home>/<End> keys in command line mode.
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
if &term =~ 'tmux' || &term =~ 'screen'
  cnoremap <Esc>[1;5D <C-Left>
  cnoremap <Esc>[1;5C <C-Right>
endif

" 删除所有行尾多余的空白（空格或 tab ）
nmap <F12> :call ClearTrailingSpaces()<CR>

func! ClearTrailingSpaces()
  let g:winview = winsaveview()
  %s/\s\+$//e
  call histdel('search', -1)
  let @/ = histget('search', -1)
  nohls
  call winrestview(g:winview)
  echo 'Trailing spaces cleared'
endfunc

" 取消搜索结果高亮
nmap <F11> :nohls<CR>

" mark (highlight) me: Search for the current word but stay put
nmap mm *N:hls<CR>

" 将大写 Y 改成从光标位置复制到行尾以与大写 D 对应
nnoremap Y y$

" ------------------------------------------------------------
" Stolen from https://github.com/tpope/vim-unimpaired.
" `cp` (create paste) to set up `:help paste` mode.
" After pressing `cp`, the next time you enter insert mode, `paste` will
" already be set. Leaving insert mode restores `nopaste` automatically.
" useful for when pasting from clipboard when vim cannot access it
" (e.g., vim without clipboard support, or when vim running remotely over ssh).

nnoremap cp <Plug>unimpairedPaste

nnoremap <silent> <Plug>unimpairedPaste :call <SID>SetupPaste()<CR>

function! s:RestorePaste() abort
  if exists('s:paste')
    let &paste = s:paste
    let &mouse = s:mouse
    unlet s:paste
    unlet s:mouse
  endif
  autocmd! unimpaired_paste
endfunction

function! s:SetupPaste() abort
  let s:paste = &paste
  let s:mouse = &mouse
  set paste
  set mouse=
  augroup unimpaired_paste
    autocmd!
    au InsertLeave * call s:RestorePaste()
    if exists('##ModeChanged')
      autocmd ModeChanged *:n call s:RestorePaste()
    else
      autocmd CursorHold,CursorMoved * call s:RestorePaste()
    endif
  augroup end
endfunction

" ------------------------------------------------------------
" stamp: 用复制内容替换选中内容
" 正常操作下。选中文字后若用 `p` 粘贴。粘贴板内容会更新为选中的内容。但常常我们
" 需要用复制的内容进行多次替换。该 stamp 功能保证粘贴后保留剪切板内原先的内容。
" 如果已经进入输入模式（如使用 `ciw` 来编辑一个词时）。可以使用 <C-r>0 以插入剪
" 切板（register 0）的内容。该方法的好处在于支持用 `.` 重现操作。
" https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text
xnoremap <silent> s p:let @+=@0<CR>:let @"=@0<CR>

" Jump to previous/next quickfix finding.
nnoremap [q :cprev<CR>
nnoremap ]q :cnext<CR>
nnoremap qq :cclose<CR>

" Jump to previous/next buffer.
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>

" ------------------------------------------------------------
" 使用 ]i 移动到下一个相同缩进行
" 使用 [i 移动到前一个相同缩进行
" 使用 ]I 和 [I 移动到下/前一个比当前缩进浅一级的行
nnoremap <silent> [i :call NextIndent(0, 0, 0, 1)<CR>
nnoremap <silent> ]i :call NextIndent(0, 1, 0, 1)<CR>
nnoremap <silent> [I :call NextIndent(0, 0, 1, 1)<CR>
nnoremap <silent> ]I :call NextIndent(0, 1, 1, 1)<CR>
vnoremap <silent> [i <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> ]i <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
vnoremap <silent> [I <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
vnoremap <silent> ]I <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
onoremap <silent> [i :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> ]i :call NextIndent(0, 1, 0, 1)<CR>
onoremap <silent> [I :call NextIndent(1, 0, 1, 1)<CR>
onoremap <silent> ]I :call NextIndent(1, 1, 1, 1)<CR>

" exclusive (bool)  : Motion is exclusive?
" fwd (bool)        : Go to next / previous line
" lowerlevel (bool) : Go to line with lower / same indentation level
" skipblanks (bool) : Skip blank lines?
func! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe 'normal ' column . '|'
        return
      endif
    endif
  endwhile
endfunc

" ------------------------------------------------------------
" Stolen from https://github.com/tpope/vim-unimpaired.
" `[d`/`]d` to jumpt to the previous/next diff conflict marker.

nnoremap [d <Plug>(unimpaired-context-previous)
nnoremap ]d <Plug>(unimpaired-context-next)
xnoremap [d <Plug>(unimpaired-context-previous)
xnoremap ]d <Plug>(unimpaired-context-next)
onoremap [d <Plug>(unimpaired-context-previous)
onoremap ]d <Plug>(unimpaired-context-next)

nnoremap <silent> <Plug>(unimpaired-context-previous) :<C-U>call <SID>Context(1)<CR>
nnoremap <silent> <Plug>(unimpaired-context-next)     :<C-U>call <SID>Context(0)<CR>
vnoremap <silent> <Plug>(unimpaired-context-previous) :<C-U>exe 'normal! gv'<Bar>call <SID>Context(1)<CR>
vnoremap <silent> <Plug>(unimpaired-context-next)     :<C-U>exe 'normal! gv'<Bar>call <SID>Context(0)<CR>
onoremap <silent> <Plug>(unimpaired-context-previous) :<C-U>exe 'normal! -V'<Bar>call <SID>Context(1)<CR>
onoremap <silent> <Plug>(unimpaired-context-next)     :<C-U>exe 'normal! +V'<Bar>call <SID>Context(0)<CR>

function! s:Context(reverse) abort
  call search('^\(@@ .* @@\|[<=>|%+]\{7}[<=>|%+]\@!\)', a:reverse ? 'bW' : 'W')
endfunction

" ------------------------------------------------------------

" 使回退键（backspace）正常跨行
set backspace=indent,eol,start

" 允许左右移动跨越行边界
" set whichwrap+=<,>,h,l

" 文件切换控制
try
  " Requires fzf.vim
  nnoremap gb :Buffers<CR>
catch
  nnoremap gb :ls<CR>:buffer<space>
endtry

" 使用 ctrl+j,k,h,l 在分割的视窗间跳动
" vim-tmux-navigator extends this to also jump between tmux panes.
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" 把 `<counter>j` 加到 jumplist 中以便 `<C-o>` 返回
" 方便在 `relativenumber` 模式下移动
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

com! DiffEdit w !vim - -c ":vnew % | windo diffthis"

" Ranged search
" Alternatively, select a range and then use `/\%Vpattern` to search.
com! -nargs=* -range RSearch /\%><line1>l\%<<line2>l<args>
xnoremap g/ <Esc>/\%V

" 将文件 <EOL> 改为 UNIX 格式
func! s:unix_eol()
  e ++ff=dos | setlocal ff=unix | update
  %s/\r//ge
endfunc
com! UnixEOL call <SID>unix_eol()

" ========================================================================= }}}
" 别名、缩写、自动纠错
" ========================================================================= {{{

ia hte the

" ========================================================================= }}}
" 搜索和匹配
" ========================================================================= {{{

" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=5

" 'smartcase' 搜索时默认忽略大小写。当搜索内容含有大写时匹配大小写
" 必须和 'ignorecase' 一起用
set ignorecase smartcase

" 搜索时随输入逐字符亮
set incsearch

" 对空白字符的显示配置
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<
" 显示空白字符。配置见 `listchars`
set list

" 关闭铃声警示
set noerrorbells
" visualbell replaces bell with t_vb, by setting it and clearing t_vb, bells
" are disabled completely. See https://vim.fandom.com/wiki/Disable_beeping.
set visualbell t_vb=

" F3 to grep. Default to the path where the focused file is at.
func! Grep(path, ...)
  " Runs grep in a non-blocking sub-shell.
  " Traditionally one would use `silent grep | redraw!` but it causes the screen to flicker a bit
  " and leaves the output in the parent shell (so you will see it after exiting vim).
  return system(&grepprg . ' "' . join(a:000, ' ') . '" ' . expandcmd(a:path))
endfunc
com! -nargs=+ -complete=file_in_path -bar Grep cgetexpr Grep(<f-args>)
nnoremap <F3> :Grep %:h<Space>

" 在已打开的文件中搜索（grep）
nmap <C-F3> :BufGrep<Space>

" 使用 Vim[grep] 来 grep
func! MyQuickGrep()
  let pattern = input('Search for pattern: ')
  let filename = input('Search in files: ', '%:h/**/*')
  exe 'redraw'

  if (pattern == '')
    echohl WarningMsg | echo 'Please enter a search pattern' | echohl None
    exe "normal \<Esc>"
  elseif (filename == '')
    "echohl WarningMsg | echo 'Please enter filename(s)' | echohl None
    "exe "normal \<Esc>"
    let filename = '*'
  endif
  try
    exe 'silent grep! ' . pattern . ' ' . filename . '|copen'
    return
  endtry
  try
    exe 'vimgrep /' . pattern . '/j ' . filename . '|copen'
    " j option inhibits jumping to search results
    " open quickfix for result browsing
  endtry
endfunc

com! -nargs=* BufGrep :call MyQuickBufGrep(<q-args>)

func! MyQuickBufGrep(pattern)
  let l:pattern = a:pattern
  if l:pattern == ''
    let l:pattern = input('Search for pattern: ')
  endif
  " Clear quickfix list.
  cexpr []
  exe 'silent bufdo vimgrepadd ' . l:pattern . ' %'
  botright cwindow
endfunc

" ========================================================================= }}}
" 文本格式和排版
" ========================================================================= {{{

" 侦测文件类型
filetype on
" 根据文件类型改变一些配置。如文本宽度、注释格式等
filetype plugin on
filetype indent on

" 将特殊后缀的文件设置为相应格式
if has('autocmd')
  augroup filetypes
    autocmd!
    au BufReadPost,BufNewFile *.mk setlocal filetype=markdown
    au BufReadPost,BufNewFile *.notes setlocal filetype=notes
    au BufReadPost,BufNewFile *.glos setlocal filetype=glos
    au BufReadPost,BufNewFile *.gdairy setlocal filetype=gdairy
    au BufReadPost,BufNewFile *.ts setlocal filetype=javascript
    au BufReadPost,BufNewFile *.ass setlocal filetype=ass
    au BufReadPost,BufNewFile *.srt setlocal filetype=srt
    au BufReadPost,BufNewFile {.,}todo*.cfg,*/{.,}todo/*.cfg setlocal filetype=sh
  augroup end
endif

" 继承前一行的缩进方式、在大括号内增加缩进等等
set autoindent smartindent
" smartindent 会使得 # 号永远左顶行首。用下面这个方式取消该效果
" 注意这里 ^H 是一个字符（输入 <C-v><C-h> 得到）。表示回退
inoremap # X#

" 制表符显式为 n 个空格长、缩进为 n 个空格长
set tabstop=2 shiftwidth=2
set smarttab        " 使 softtabstop = shiftwidth
" 使用空格填充制表符
set expandtab

set nowrap

if has('autocmd')
  augroup commentstring
    autocmd!
    au BufReadPost,BufNewFile .hgrc setlocal commentstring=#\ %s
    au BufReadPost,BufNewFile sxhkdrc,*.sxhkdrc setlocal commentstring=#\ %s
  augroup end
endif

" vim 自带补全功能的列表索引次序
" 默认值 . , w , b , u , U , t , i
" 补全列表会先搜索当前文件(.)
" 再搜索其他窗口(w)
" 再搜索其他缓冲区(b)
" 再搜索已经卸载的缓冲区(u)
" 再搜索不在缓冲区列表中的缓冲区，即工作路径中的缓冲区(U)
" 再搜索 tags (t)
" 最后搜索源码中通过 #include 包含进来的头文件(i)
set complete=.,w,b,u
set completeopt=menuone,menu,longest

" 文本格式化设置
set formatoptions=
set formatoptions+=cqjr     " 支持注释
set formatoptions+=n        " 支持列表，不要和 '2' 一起用
set formatoptions+=mB       " 方便中文文本操作
set formatoptions+=t
" 自动文本格式化的行宽
set textwidth=79

" 如下符号可以连接两个词（'a_b' 会被当作一个词对待）
set iskeyword+=_

" ========================================================================= }}}
" 配色
" ========================================================================= {{{

" 打开语法高亮
syntax on
if !g:isGUI
  " Turn on true-color in terminal.
  " (This might cause problems in terminal emulaters that don't support true-color.)
  " sets foreground color (ANSI, true-color mode)
  let &t_8f = "\e[38;2;%lu;%lu;%lum"
  " sets background color (ANSI, true-color mode)
  let &t_8b = "\e[48;2;%lu;%lu;%lum"
  set termguicolors
endif
set background=dark
try | colo solarized8_flat | catch | endtry

" 在终端下给拼写错误标上下划线
if has('autocmd')
  augroup spellhilight
    autocmd!
    au BufReadPost,BufNewFile * hi SpellBad cterm=underline
    au BufReadPost,BufNewFile * hi SpellRare cterm=underline
    au BufReadPost,BufNewFile * hi SpellLocal cterm=underline
  augroup end
endif

" ========================================================================= }}}
" Autocommands
" ========================================================================= {{{

if has('autocmd')
  augroup my_autoformats
    autocmd!
    " 打开文件时定位至关闭时位置
    au BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line('$') |
          \ exe ' normal g`"' |
          \ endif
  augroup end

  " 带有 shebang 的脚本自动保存成可执行文件
  if g:islinux
    augroup shebang
      autocmd!
      au BufWritePost * if getline(1) =~ '^#!.*/bin/' | silent execute '!chmod +x %' | endif
    augroup end
  endif

endif  " has('autocmd')

" ========================================================================= }}}
" QuickFix
" ========================================================================= {{{

" QuickFix 中文支持
" windows 默认编码为 cp936，而 Gvim(Vim) 内部编码为 utf-8，所以常常输出为乱码
" 以下代码可以将编码为 cp936 的输出信息转换为 utf-8 编码，以解决输出乱码问题
" 但好像只对输出信息全部为中文才有满意的效果，如果输出信息是中英混合的，那可能
" 不成功，会造成其中一种语言乱码，输出信息全部为英文的好像不会乱码
" 如果输出信息为乱码的可以试一下下面的代码，如果不行就还是给它注释掉

if g:iswindows
  augroup chinse_quick_fix
    autocmd!
    au QuickfixCmdPost make call QfMakeConv()
    func! QfMakeConv()
      let qflist = getqflist()
      for i in qflist
        let i.text = iconv(i.text, 'cp936', 'utf-8')
      endfor
      call setqflist(qflist)
      exec 'cw'
    endfunc
  augroup end
endif

" Automatically open/close the quickfix window when quickfix list changes.
augroup cwindow
  autocmd!
  autocmd QuickfixCmdPost cgetexpr cwindow
  autocmd QuickfixCmdPost lgetexpr cwindow
augroup end

" ========================================================================= }}}
" netrw
" ========================================================================= {{{

" TODO: i prefer `3` (tree style) but that causes errors when opening symlinks.
" change to `3` after https://github.com/vim/vim/pull/3609 is merged.
let g:netrw_liststyle = 0 " list style
let g:netrw_winsize = 20 " percent
" let g:netrw_browse_split = 4 " open files in previous window
let g:netrw_banner = 0
let g:netrw_bufsettings = 'nomodifiable nomodified readonly number nobuflisted nowrap'

" ========================================================================= }}}
" 编码配置
" ========================================================================= {{{

" 注：使用 utf-8 格式后，软件与程序源码、文件路径不能有中文，否则报错
" 设置支持打开的文件的编码
set fileencodings=ucs-bom,utf-8,cp936,utf-16le,gbk,chinese,big5,euc-jp,euc-kr,gb18030,ucs,gb2312
" 设定写入文件使用的解码
set encoding=utf-8 termencoding=utf-8
if &modifiable
  set fileencoding=utf-8
endif

" 设置支持的 <EOL> 格式
set fileformats=unix
" 设置写入文件的 <EOL> 格式
if &modifiable
  set fileformat=unix
endif

" 将程序语言设为英文
" 设置信息语言
let $LANG = 'en_US.utf-8'
" 设置菜单语言
set langmenu=en

" 设置拼写检查语言为美式英语
set spelllang=en_us
" 使拼写检查忽略东亚字符
set spelllang+=cjk

" ========================================================================= }}}
" 加载本地配置 ~/.vim/configs/*.vim
" ========================================================================= {{{
for rc_path in glob('~/.vim/configs/*.vim', 1, 1)
  if filereadable(rc_path)
    exec 'source '.rc_path
  endif
endfor

" ========================================================================= }}}
" NOTES
" ========================================================================= {{{
" %   带路径的当前文件名
" %:h 文件路径。例 "../path/test.c" -> "../path"
" %:t 不带路径的文件名。例 "../path/test.c" -> "test.c"
" %:r 无扩展名的文件名。例 "../path/test.c" -> "../path/test"
" %:e 扩展名
"
" 需要移动的操作指令（qm 后跟寄存器而非移动）
" yd[]zcv mqg
" 不需要移动的操作指令
" ruiopasx
" }}}

" vim:nowrap:tw=0:fdm=marker:fen:
