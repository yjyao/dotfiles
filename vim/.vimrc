" 辅助变量配置 {{{
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
" vim-plug - Load plugins
" ========================================================================= {{{
" *** Keep this at the top of file. ***
" https://github.com/junegunn/vim-plug

if !empty(glob(g:vimfiles_dir . '/autoload/plug.vim'))
  call plug#begin(g:vimfiles_dir . '/bundle')

  " Plug 'Align'  " use vim-easy-align instead
  Plug 'JikkuJose/vim-visincr'  " quickly create consecutive numbers
  " Plug 'LaTeX-Box-Team/LaTeX-Box'  " use vimtex instead
  " Plug 'Lokaltog/vim-powerline'
  " Plug 'Mark--Karkat'
  " Plug 'Shougo/neocomplete'  " fuzzy completion (does NOT support vim 8.2+)
  Plug 'SirVer/ultisnips'
  " Plug 'TxtBrowser'
  " Plug 'Valloric/YouCompleteMe'  " use neocomplete instead
  Plug 'Vimjas/vim-python-pep8-indent'
  " Plug 'Yggdroot/indentLine'
  " Plug 'ZoomWin'
  " Plug 'a.vim'
  Plug 'altercation/vim-colors-solarized'  " colorscheme
  " Plug 'artur-shaik/vim-javacomplete2'
  Plug 'bkad/CamelCaseMotion'
  " Plug 'cSyntaxAfter'
  " Plug 'ccvext.vim'
  Plug 'chrisbra/csv.vim'
  Plug 'christoomey/vim-sort-motion'  " vim-object-friendly sorting motion
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'cohama/lexima.vim'  "  auto pair closer
  " Plug 'ctrlpvim/ctrlp.vim'  " fuzzy file searcher / buffer manager
  " Plug 'davidhalter/jedi-vim'  "  python autocomplete. 'pip install jedi' required
  Plug 'derekwyatt/vim-fswitch'  " switch between source/code files
  " Plug 'dyng/ctrlsf.vim'  " global search
  Plug 'fatih/vim-go'
  Plug 'fcpg/vim-waikiki'  " Wiki system: Link and tag handling.
  Plug 'honza/vim-snippets'  " provides a bunch of snippets
  " Plug 'javacomplete'
  " Plug 'jiangmiao/auto-pairs'  " use lexima + vim-surround instead
  Plug 'junegunn/fzf'  " fuzzy finder
  Plug 'junegunn/fzf.vim'  " fuzzy finder extended
  Plug 'junegunn/vim-easy-align'
  " Plug 'justinmk/vim-sneak'  " 2-letter `f` and `t`
  Plug 'lervag/vimtex'  " LaTeX build / functions
  " Plug 'majutsushi/tagbar'
  Plug 'mattn/emmet-vim'  " https://emmet.io: fast HTML coding
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'neoclide/coc-snippets'
  Plug 'neoclide/coc-sources'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}  " async completion with lsp support
  " Plug 'osyo-manga/vim-over'  " :s preview
  Plug 'rickhowe/diffchar.vim'
  Plug 'romainl/vim-cool'  "  auto disable search highlights
  " Plug 'scrooloose/nerdcommenter'  " use vim-commentary instead
  " Plug 'scrooloose/nerdtree'  " use built-in netrw instead
  " Plug 'scrooloose/syntastic'
  " Plug 'shawncplus/phpcomplete.vim'
  " Plug 'std_c.zip'
  " Plug 'taglist.vim'
  Plug 'takac/vim-hardtime'  " prevents bad habbits
  Plug 'tenfyzhong/axring.vim'  " extends <c-a>/<c-x>, load BEFORE speeddating
  Plug 'tpope/vim-commentary'  " motions for commenting code
  Plug 'tpope/vim-markdown'
  Plug 'tpope/vim-repeat'  " make `.` repeat some plugin motions. just keep
  Plug 'tpope/vim-speeddating'  " extends <c-a>/<c-x> to work with dates
  Plug 'tpope/vim-surround'  " motions for surrounding text with paren/etc.
  Plug 'unblevable/quick-scope'  " highlight cues for `f` and `t`
  " Plug 'vim-javacompleteex'
  Plug 'vim-scripts/OmniCppComplete'
  " Plug 'vim-scripts/VimIM'
  Plug 'vim-scripts/closetag.vim'  " close HTML tags with <C-BS>
  Plug 'wellle/context.vim'  " Freeze first line of each indentation level
  Plug 'wellle/targets.vim'  " objects like arg; search-ahaed paren-objects
  " Plug 'wesleyche/SrcExpl'
  Plug 'whiteinge/diffconflicts'
  Plug 'wsdjeg/vim-fetch'  " Support filepath:line:col syntax.
  Plug 'yjyao/recap.vim'

  " end-of-local-plugins

  let b:extra_plugins = g:vimfiles_dir . '/plugins.vim'
  if filereadable(expand(b:extra_plugins))
    exec 'source '.b:extra_plugins
  endif

  call plug#end()

  " Don't use `PlugUpgrade`, instead update the git submodule
  "   $ git submodule update --remote vim/.vim/bundle/vim-plug/
  delc PlugUpgrade

endif  " if has vim-plug

" Always keep the plugin list sorted.
if has('autocmd')
  augroup sort_plugins
    autocmd!
    autocmd BufLeave .vimrc execute 'normal mz' | setlocal nofoldenable | 0/plug#begin/+2,0/end-of-local-plugins/-2 sort /^\s*\("\s*\)\?/ | normal `z
  augroup end
endif

func! g:HasPlug(name)
  " The vim-plug manager defines `g:plugs`.
  return exists('g:plugs') && has_key(g:plugs, a:name)
endfunc

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
if g:HasPlug('csv.vim')
  set statusline+=%=%{exists('*CSV_WCol')&&\ &ft=~'csv'?'[COL='.CSV_WCol('Name').']\ ':''}
endif
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

" 自动改变 vim 的当前目录为打开的文件所在目录
set autochdir

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

" 每次命令行命令后告诉我们共更改了文件多少行内容
" 如 :s 之后会得到如 "3 substitutions on 1 line" 的提示
set report=0

" mswin 下 visual 改成了 exclusive 。恢复默认
set selection=inclusive

" Load help files under doc/
if !empty(glob(g:vimfiles_dir . '/doc'))
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
  set grepprg=rg\ --vimgrep\ --no-heading\ --color=never
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

" ========================================================================= }}}
" 操作
" ========================================================================= {{{

" 不要使用 vi 的键盘模式，而是 vim 的
set nocompatible

" 设置 leader 健
let mapleader = "\<Space>"
let maplocalleader = mapleader

" 保存
" nnoremap <C-s> :update<CR>
" inoremap <C-s> <Esc>:update<CR>
nnoremap <Leader>s :update<CR>

" 使用 kj 退出到命令模式（同 Esc）
inoremap kj <Esc>

" Shell 习惯的 <Home> / <End>
inoremap <C-a> <Esc>I
inoremap <C-e> <Esc>A

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

" change vimrc
exec 'nmap crc :tabnew ' . g:vimrc_path . '<CR>'

" config update
exec 'nmap cu :source ' . g:vimrc_path . '<CR>'

" 在命令行下使用 ctrl-v 粘贴
cmap <C-v> <C-r>+

" <C-a> to go to beginning of line (emacs mode!) in commandline mode.
cnoremap <C-a> <Home>

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

" ctrl-c 计算器
if has('python')
  imap <silent> <C-c> <C-r>=pyeval(input('Calculate: '))<CR>
else
  imap <silent> <C-c> <C-r>=string(eval(input('Calculate: ')))<CR>
endif

" mark (highlight) me: Search for the current word but stay put
nmap mm *N:hls<CR>

" 将大写 Y 改成从光标位置复制到行尾以与大写 D 对应
nnoremap Y y$

nmap yp :call PlainPaste(1)<CR>
nmap yP :call PlainPaste(0)<CR>

func! PlainPaste(forward)
  let l:ispaste = &paste
  set nopaste
  if a:forward
    norm p
  else
    norm P
  endif
  let &paste = l:ispaste
endfunc

" stamp: 用复制内容替换选中内容
" 正常操作下。选中文字后若用 `p` 粘贴。粘贴板内容会更新为选中的内容。但常常我们
" 需要用复制的内容进行多次替换。该 stamp 功能保证粘贴后保留剪切板内原先的内容。
" 如果已经进入输入模式（如使用 `ciw` 来编辑一个词时）。可以使用 <C-r>0 以插入剪
" 切板（register 0）的内容。该方法的好处在于支持用 `.` 重现操作。
" https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text
xnoremap <silent> s p:let @+=@0<CR>:let @"=@0<CR>

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

" 使用方向键以在被折叠的行间移动
nnoremap <Up> gk
vnoremap <Up> gk
inoremap <Up> <C-o>gk
nnoremap <Down> gj
vnoremap <Down> gj
inoremap <Down> <C-o>gj

" 使回退键（backspace）正常跨行
set backspace=indent,eol,start

" 允许左右移动跨越行边界
" set whichwrap+=<,>,h,l

" 文件切换控制
if g:HasPlug('fzf.vim')
  nmap gb :Buffers<CR>
elseif g:HasPlug('ctrlp.vim')
  nmap gb :CtrlPBuffer<CR>
else
  nmap gb :ls<CR>:buffer<space>
endif

" 使用 ctrl+j,k,h,l 在分割的视窗间跳动
if !g:HasPlug('vim-tmux-navigator')
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-h> <C-w>h
  nnoremap <C-l> <C-w>l
endif

" 标签控制
" 使用 ctrl+Tab 切换标签
nnoremap <C-Tab> :tabnext<CR>
nnoremap <C-S-Tab> :tabprevious<CR>

com! DiffEdit w !vim - -c ":vnew % | windo diffthis"

" Ranged search
com! -nargs=* -range RSsearch /\%><line1>l\%<<line2>l<args>

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

" F3 在工作路径中搜索（grep）
nnoremap <F3> :silent grep '' %:h \| cw<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

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

" 打开语法高亮。同时也为 solarized 所要求
syntax on
if !g:isGUI
  set t_Co=16
  let g:solarized_termcolors = 16
  let g:solarized_termtrans = 1  " Disable solarized background color.
endif
set background=dark
try | colo solarized | catch | endtry

" 在终端下给拼写错误标上下划线
if has('autocmd')
  augroup spellhilight
    autocmd!
    autocmd BufReadPost,BufNewFile * hi SpellBad cterm=underline
    autocmd BufReadPost,BufNewFile * hi SpellRare cterm=underline
    autocmd BufReadPost,BufNewFile * hi SpellLocal cterm=underline
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
" 自定义函数
" ========================================================================= {{{

" ------------------------------------------------------------
" 包围选中的文本

func! WrapTextWith(left, right)
  exe "norm `<i \<Esc>r".a:left."`>la \<Esc>r".a:right
endfunc

" ------------------------------------------------------------
" 将文件 <EOL> 改为 UNIX 格式

func! UnixEOL()
  e ++ff=dos | setlocal ff=unix | update
  exe '%s+\r++ge'
endfunc

" ========================================================================= }}}
" 插件配置
" ========================================================================= {{{

" -----------------------------------------------------------------------------
" a.vim
" -----------------------------------------------------------------------------
" 用于切换 C/C++ 头文件
" :A     --- 切换头文件并独占整个窗口
" :AV    --- 切换头文件并垂直分割窗口
" :AS    --- 切换头文件并水平分割窗口

" -----------------------------------------------------------------------------
" QuickFix
" -----------------------------------------------------------------------------

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

" -----------------------------------------------------------------------------
" TagList & Ctags
" -----------------------------------------------------------------------------
" 对于C++代码，ctags需要额外使用以下选项：
" 为标签添加函数原型(prototype)信息
" --c++-kinds=+p
" 为标签添加继承信息(inheritance)，访问控制(access)信息，
" 函数特征(function Signature,如参数表或原型等)
" --fields=+iaS
" 为类成员标签添加类标识
" --extra=+q
set tags=tags

" 配置 TagList 的 ctags 路径
let Tlist_Ctags_Cmd = '%VIMRUNTIME%/ctags.exe'

" 按照名称排序
let Tlist_Sort_Type = 'name'

" 压缩方式
" let Tlist_Compart_Format = 1

" 如果 taglist 窗口是最后一个窗口，则退出 vim
let Tlist_Exist_OnlyWindow = 1

" 不要显示折叠树
let Tlist_Enable_Fold_Column = 1

" 让当前不被编辑的文件的方法列表自动折叠起来
let Tlist_File_Fold_Auto_Close = 0

let Tlist_Show_One_File = 0

nmap <Leader>tl :TlistToggle<CR>

" -----------------------------------------------------------------------------
" OmniCppComplete
" -----------------------------------------------------------------------------

" 打开全局查找控制
let OmniCpp_GlobalScopeSearch = 1

" 类成员显示控制，不显示所有成员
let OmniCpp_DisplayMode = 0

" 控制匹配项所在域的显示位置。
" 缺省情况下，omni显示的补全提示菜单中总是将匹配项所在域信息显示在缩略信息最后一列。
" 0 : 信息缩略中不显示匹配项所在域(缺省)
" 1 : 显示匹配项所在域，并移除缩略信息中最后一列
let OmniCpp_ShowScopeInAbbr = 0

" 显示参数列表
let OmniCpp_ShowPrototypeInAbbr = 1

" 显示访问控制信息('+', '-', '#')
let OmniCpp_ShowAccess = 1

" 默认命名空间列表
let OmniCpp_DefaultNamespaces = ['std', '_GLIBCXX_STD']

" 是否自动选择第一个匹配项。仅当"completeopt"不为"longest"时有效。
" 0 : 不选择第一项(缺省)
" 1 : 选择第一项并插入到光标位置
" 2 : 选择第一项但不插入光标位置
let OmniCpp_SelectFirstItem = 0

" 使用Vim标准查找函数/本地(local)查找函数
" Vim内部用来在函数中查找变量定义的函数需要函数括号位于文本的第一列
" 而本地查找函数并不需要。
let OmniCpp_LocalSearchDecl = 1

" 命名空间查找控制。
" 0 : 禁止查找命名空间
" 1 : 查找当前文件缓冲区内的命名空间(缺省)
" 2 : 查找当前文件缓冲区和包含文件中的命名空间
let OmniCpp_NamespaceSearch = 1

" C++ 成员引用自动补全
if !g:HasPlug('neocomplete')
  let OmniCpp_MayCompleteDot = 1                  " 输入 . 后自动补全
  let OmniCpp_MayCompleteArrow = 1                " 输入 -> 后自动补全
  let OmniCpp_MayCompleteScope = 1                " 输入 :: 后自动补全
endif

" 自动关闭补全窗口
if has('autocmd')
  augroup auto_close_completion
    autocmd!
    au CursorMovedI,InsertLeave * if pumvisible() == 0 | silent! pclose | endif
  augroup end
endif

" -----------------------------------------------------------------------------
" Jedi-vim
" -----------------------------------------------------------------------------
" python 补全

" Disable goto (typing) stubs shortcut (Defaults to <Leader>s, conflicting with
" our save shortcut).
let g:jedi#goto_stubs_command = ""

" 优先用 NeoComplete 来进行补全
if g:HasPlug('neocomplete')
  let g:jedi#completions_enabled = 0
  let g:jedi#auto_vim_configuration = 0
  let g:jedi#smart_auto_mappings = 0
endif

" -----------------------------------------------------------------------------
" NeoComplete
" -----------------------------------------------------------------------------
" 关键字补全、文件路径补全、tag 补全等等
" 需要 +lua

" let g:acp_enableAtStartup = 0                       " 禁止内置自动补全
let g:neocomplete#enable_at_startup = 1             " 随 Vim 启动
let g:neocomplete#enable_smart_case = 1             " 只在输入大写字母时对大小写敏感
let g:neocomplete#auto_completion_start_length = 3  " 只在输入超过三个字符时自动打开补全菜单
let g:neocomplete#sources#syntax#min_keyword_length = 4
" 默认情况下，在 NeoComplete 补全时按下退格键会撤销补全。这里改为应用补全并删去一个字符
if g:HasPlug('neocomplete')
  inoremap <expr><C-h> neocomplete#close_popup()."\<C-h>"
  inoremap <expr><BS>  neocomplete#close_popup()."\<C-h>"
endif

" let g:neocomplete#sources#dictionary#dictionaries = {
"     \ 'default' : '',
"     \ 'vimshell' : $HOME.'/.vimshell_hist',
"     \ 'scheme' : $HOME.'/.gosh_completions'
"         \ }

" 词段分割符
if !exists('g:neocomplete#delimiter_patterns')
    let g:neocomplete#delimiter_patterns = {}
endif
let g:neocomplete#delimiter_patterns.tex = ['{']

" 关键词正规表达
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns.tex =
            \'\\\a{\a\{1,2}}'           .'\|'.
            \'\\[[:alpha:]@][[:alnum:]@]*\%({\%([[:alnum:]:_]\+\*\?}\?\)\?\)\?' .'\|'.
            \'\a[[:alnum:]:_-]*\*\?'

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.java = '\%(\h\w*\|)\)\.\w*'

" Enable force omni completion.
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif

" "omnifunc" enabled in $vimfiles/after/ftplugin/python.vim.

let g:neocomplete#force_omni_input_patterns.python =
            \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

" -----------------------------------------------------------------------------
" VimIM
" -----------------------------------------------------------------------------
" Vim 内的中文输入法

let g:Vimim_cloud = ''
" let g:Vimim_map = ''
" let g:Vimim_mode = 'dynamic'
" let g:Vimim_mycloud = 0
" let g:Vimim_shuangpin = 0
" let g:Vimim_toggle = ''

" 防止与 NeoComplete 的冲突
let g:Vimim_chinse_mode_on = 0
func! VIMIM_before()
  if exists(':NeoCompleteDisable') == 2
        \ && g:Vimim_chinse_mode_on == 0
    exe 'NeoCompleteLock'
    exe 'NeoCompleteDisable'
    let g:Vimim_chinse_mode_on = 1
  elseif exists(':NeoCompleteEnable') == 2
        \ && g:Vimim_chinse_mode_on == 1
    exe 'NeoCompleteUnlock'
    exe 'NeoCompleteEnable'
    let g:Vimim_chinse_mode_on = 0
  endif
endfunc

if g:HasPlug('VimIM')
  " 使用 ctrl-space 打开 / 关闭 VimIM
  inoremap <C-Space> <Space><Esc>:call VIMIM_before()<CR>s<C-r>=g:Vimim_chinese()<CR>
  nnoremap <C-Space> :call VIMIM_before()<CR>a<C-r>=g:Vimim_chinese()<CR><Esc>
endif

" 使用文中标点
let g:Vimim_punctuation = 3

" -----------------------------------------------------------------------------
" auto-pairs
" -----------------------------------------------------------------------------

" 关闭 fly mode （输入右括号跳到括号结束处）
let g:AutoPairsFlyMode = 0

" 将输入闭括号自动跳过下一个紧接的闭括号的功能限制在当前行内
let g:AutoPairsMultilineClose = 0

" -----------------------------------------------------------------------------
" lexima
" -----------------------------------------------------------------------------

imap <C-h> <BS>
cmap <C-h> <BS>

try
  call lexima#add_rule({
        \  'char': '<CR>', 'at': '{\%#}',
        \  'input' : '%<CR>', 'input_after': '<CR>',
        \  'filetype' : 'tex',
        \ })
  call lexima#add_rule({
        \  'char': '<CR>', 'at': '\[\%#]',
        \  'input' : '%<CR>', 'input_after': '<CR>',
        \  'filetype' : 'tex',
        \ })
  call lexima#add_rule({
        \  'char': '``',
        \  'input_after': "''",
        \  'filetype' : 'tex',
        \ })
catch
endtry

" -----------------------------------------------------------------------------
" fzf
" -----------------------------------------------------------------------------

let $FZF_DEFAULT_OPTS = '--layout=default --info=inline --bind "ctrl-j:ignore,ctrl-k:ignore"'

" Use the <C-p> convention from ctrlp.vim to trigger file search.
if g:HasPlug('fzf') && !g:HasPlug('ctrlp.vim')
  nnoremap <C-p> :FZF %:h<CR>

  augroup fzf_window
    autocmd!
    " Fix <C-w> for backward-kill-word.
    autocmd FileType fzf tnoremap <buffer> <c-w> <c-w>.
  augroup END

  " NOTE: This currently does not support directory changes within the fzf
  " invocation. https://github.com/junegunn/fzf.vim/issues/338 provides
  " workarounds. Check it out if interested.

endif

" Put fzf.vim options below this line.

let g:fzf_preview_window = []  " Disable preview windows.

" -----------------------------------------------------------------------------
" ctrlp
" -----------------------------------------------------------------------------
" 一个全路径模糊文件，缓冲区的检索插件
" 常规模式下输入：ctrl-p 调用插件

if g:iswindows
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe
else
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip
endif

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|out|cache)$',
  \ 'file': '\v\.(exe|so|dll|aux|pdf|class)$',
  \ }

let g:ctrlp_working_path_mode = 'rc'

let g:ctrlp_max_depth = 4

let g:ctrlp_follow_symlinks = 1

if executable('fd')
  let g:ctrlp_user_command = 'fd ^ %s --type f --color=never --follow
        \ --hidden
        \ --exclude .git
        \ --exclude .cache
        \ --exclude .svn
        \ --exclude .hg
        \ --exclude .DS_Store
        \ --exclude "**/*.pyc"
        \ --exclude .git5_specs
        \ --exclude .review
        \ --exclude "*.aux"
        \ --exclude "*.pdf"
        \ --exclude "*.exe"
        \ --exclude "*.class"
        \ --exclude "*.dll"
        \ --exclude "*.out"
        \ '
  let g:ctrlp_use_caching = 0
elseif executable('ag')
  let g:ctrlp_user_command = '/usr/bin/ag %s -i --nocolor --nogroup --follow
        \ --hidden
        \ --ignore .git
        \ --ignore .cache
        \ --ignore .svn
        \ --ignore .hg
        \ --ignore .DS_Store
        \ --ignore "**/*.pyc"
        \ --ignore .git5_specs
        \ --ignore .review
        \ --ignore "*.aux"
        \ --ignore "*.pdf"
        \ --ignore "*.exe"
        \ --ignore "*.class"
        \ --ignore "*.dll"
        \ --ignore "*.out"
        \ -g ""'
  let g:ctrlp_use_caching = 0
endif

" -----------------------------------------------------------------------------
" fswitch
" -----------------------------------------------------------------------------

augroup related_file
  autocmd!
  autocmd BufEnter *.cc let b:fswitchdst = 'h,hh'
  autocmd BufEnter *.h let b:fswitchdst = 'c,cc,cpp'
augroup end

" hotkey: goto related file
if g:HasPlug('vim-fswitch')
  nnoremap <silent> gr :FSHere<CR>
else
  nnoremap gr :e %:p:s,.h$,.X123X,:s,.cc$,.h,:s,.X123X$,.cc,<CR>
endif

" -----------------------------------------------------------------------------
" emmet-vim
" -----------------------------------------------------------------------------
" HTML/CSS 代码快速编写神器

" don't automatically install emmet.
" to list all filetypes with emmet enabled, run
"     $ grep -lr EmmetInstall ~/.vim/ | grep plugin/
let g:user_emmet_install_global = 0

let g:user_emmet_leader_key = '<C-e>'

" -----------------------------------------------------------------------------
" NerdCommenter
" -----------------------------------------------------------------------------
" 以下为插件默认快捷键，其中的说明是以C/C++为例的，其它语言类似
" <Leader>ci 以每行一个 /* */ 注释选中行(选中区域所在行)，再输入则取消注释
" <Leader>cm 以一个 /* */ 注释选中行(选中区域所在行)，再输入则称重复注释
" <Leader>cc 以每行一个 /* */ 注释选中行或区域，再输入则称重复注释
" <Leader>cu 取消选中区域(行)的注释，选中区域(行)内至少有一个 /* */
" <Leader>ca 在/*...*/与//这两种注释方式中切换（其它语言可能不一样了）
" <Leader>cA 行尾注释
" let NERDSpaceDelims = 1                     "在左注释符之后，右注释符之前留有空格
" nmap c] <Leader>cc
" vmap c] <Leader>cc
" nmap c[ <Leader>cu
" vmap c[ <Leader>cu

" -----------------------------------------------------------------------------
"  < nerdtree 插件配置 >
" -----------------------------------------------------------------------------
" 有目录村结构的文件浏览插件

" 常规模式下输入 F2 调用插件
" nmap <F2> :NERDTreeToggle<CR>

" -----------------------------------------------------------------------------
" ultisnips
" -----------------------------------------------------------------------------
" Snippet 插件
" 需要 +python
" 使用 vim-snippets 中的 (La)TeX 的标题结构模板（如 cha, sec, etc.）时，需要
" `pip install unicode`

" Trigger configuration.
" Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
inoremap <C-j> <C-o>:echo 'Not in a snippet'<CR>
inoremap <C-k> <C-o>:echo 'Not in a snippet'<CR>

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit = 'vertical'

" 添加自己的 snippets
let g:UltiSnipsSnippetsDir = g:vimfiles_dir . '/UltiSnips'

" set quoting style in python.snippets provided by vim-snippets
let g:ultisnips_python_quoting_style = 'single'

inoremap <C-l> <Esc>:Snippets<CR>
com! Snippets :call GetAllSnippets()
" https://stackoverflow.com/questions/58081390/why-doesnt-ultisnips-listing-of-available-snippets-work#tab-top
func! GetAllSnippets()
  call UltiSnips#SnippetsInCurrentScope(1)
  let list = []
  for [key, info] in items(g:current_ulti_dict_info)
    let parts = split(info.location, ':')
    call add(list, {
          \ "text": key,
          \ "filename": parts[0],
          \ "lnum": parts[1],
          \ "context": info.description,
          \ })
  endfor
  call setqflist([], ' ', { 'title': 'Snippets', 'items' : list})

  " Open Quickfix list as soon as it is populated.
  cwindow
endfunc

" ------------------------------------------------------------
" vim-markdown
" ------------------------------------------------------------

" 'java' needs to come *before* 'html': https://vi.stackexchange.com/a/18407.
let g:markdown_fenced_languages = [
      \ 'java',
      \ 'html',
      \ 'python',
      \ 'bash=sh',
      \ 'sql',
      \ 'c',
      \ 'ocaml',
      \ ]
let g:markdown_syntax_conceal = 0
let g:vim_markdown_folding_disabled = 1  " Slows down startup.

" ------------------------------------------------------------
" vimtex
" ------------------------------------------------------------

" use latexmk to compile LaTeX docs, require perl installed on machine

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

if !executable('latexmk')
  let g:vimtex_compiler_enabled = 0
endif
let g:tex_flavor = 'latex'
let g:tex_indent_items = 0
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_FormatDependency_pdf = 'pdf'
let g:vimtex_view_method = 'general'
let g:vimtex_enabled = 1
let g:vimtex_complete_img_use_tail = 1
if executable('SumatraPDF')
  " use SumatraPDF to view PDF, SumatraPDF required
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

" list of modifiers of pairs / delimiters to toggle
let g:vimtex_delim_toggle_mod_list = [
      \ ['\bigl', '\bigr'],
      \ ['\Bigl', '\Bigr'],
      \ ['\biggl', '\biggr'],
      \ ['\Biggl', '\Biggr'],
      \]
"       \ ['\left', '\right'],

let g:vimtex_indent_delims = {
      \ 'open' : ['{', '['],
      \ 'close' : ['}', ']'],
      \ 'close_indented' : 0,
      \ 'include_modified_math' : 1,
      \ }

" make neocomplete support citation / label ref / ... completions
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.tex =
      \ '\v\\%('
      \ . '\a*%(ref|cite)\a*%(\s*\[[^]]*\])?\s*\{[^{}]*'
      \ . '|includegraphics%(\s*\[[^]]*\])?\s*\{[^{}]*'
      \ . '|%(include|input)\s*\{[^{}]*'
      \ . ')'

" ------------------------------------------------------------
" LaTeX-Box
" ------------------------------------------------------------

" use latexmk to compile LaTeX docs, require perl installed on machine

" let g:LatexBox_latexmk_options = '-pdflatex='xelatex -synctex=1''
" let g:LatexBox_latexmk_async   = 0
" let g:LatexBox_latexmk_options = '-pdflatex=xelatex'
" let g:LatexBox_latexmk_async   = 0
" let g:LatexBox_latexmk_async   = 1

" ------------------------------------------------------------
" vim-easy-align
" ------------------------------------------------------------

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" ------------------------------------------------------------
" CamelCaseMotion
" ------------------------------------------------------------

" Use <Leader>[wbe] to move around in CamelCase and snake_case words.
" Also supports text object so one can ci<Leader>w

nmap <silent> <Leader>w <Plug>CamelCaseMotion_w
nmap <silent> <Leader>b <Plug>CamelCaseMotion_b
nmap <silent> <Leader>e <Plug>CamelCaseMotion_e
nmap <silent> <Leader>ge <Plug>CamelCaseMotion_ge

" CamelCase text objects
omap <silent> i<Leader>w <Plug>CamelCaseMotion_ie
xmap <silent> i<Leader>w <Plug>CamelCaseMotion_ie
omap <silent> a<Leader>w <Plug>CamelCaseMotion_iw
xmap <silent> a<Leader>w <Plug>CamelCaseMotion_iw

" ------------------------------------------------------------
" vim-surround
" ------------------------------------------------------------

" quotes
let g:surround_{char2nr('q')} = "'\r'"
let g:surround_{char2nr('Q')} = '"\r"'
" Chinese quotes.
" Windows doesn't like the unicode characters. Wrap this in autocommand to
" workaround it.
if has('autocmd')
  augroup windows_complains_unicode
    autocmd!
    "y" for 引号. "k" for 括号
    au VimEnter *
          \ let g:surround_{char2nr('y')} = "「\r」" |
          \ let g:surround_{char2nr('Y')} = "『\r』" |
          \ let g:surround_{char2nr('k')} = "（\r）" |
          \ let g:surround_{char2nr('K')} = "【\r】"
  augroup end
endif

" ------------------------------------------------------------
" sneak
" ------------------------------------------------------------

" DISABLE sneak `;` and `,`
" preserve `;` and `,` for `f` and `t` motions (so that we can
" work with other f-enhancement plugins)
" `s<CR>` and `S<CR>` does the sneak `;` and `,` already
map <Nop> <Plug>Sneak_;
map <Nop> <Plug>Sneak_,

" ------------------------------------------------------------
" quick scope
" ------------------------------------------------------------

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Underline candidates.
" The candidate highlights can blend with syntax highlights.
" Adding underlines to them can help with identifying them.
func! SetQuickScopeHighlights()
  highlight QuickScopePrimary guifg='#40ffff' gui=underline ctermfg=4 cterm=underline
  highlight QuickScopeSecondary guifg='#ff80ff' gui=underline ctermfg=9 cterm=underline
endfunc
call SetQuickScopeHighlights()
augroup qs_colors
  autocmd!
  autocmd ColorScheme * call SetQuickScopeHighlights()
augroup end

" ------------------------------------------------------------
" hardtime
" ------------------------------------------------------------

let g:hardtime_default_on = 1
let g:list_of_normal_keys = [
      \ 'h', 'j', 'k', 'l', '-', '+',
      \ '<UP>', '<DOWN>', '<LEFT>', '<RIGHT>',
      \ 'e', 'w', 'b',
      \ ]
let g:hardtime_ignore_quickfix = 1
let g:hardtime_maxcount = 3

" ------------------------------------------------------------
" targets
" ------------------------------------------------------------

if has('autocmd')
  augroup Targets
    autocmd!
    autocmd User targets#mappings#user call targets#mappings#extend({
          \ 'b': {'pair': [{'o':'(', 'c':')'}]}
          \ })
  augroup end
endif
let g:targets_nl = ['n', 'N']
" Only seek if next/last targets touch current line
let g:targets_seekRanges = 'cr cb cB lc ac Ac lr rr ll lb ar ab lB Ar aB Ab AB rb rB al Al'

" ------------------------------------------------------------
" netrw
" ------------------------------------------------------------

let g:netrw_liststyle = 3 " tree style
let g:netrw_winsize = 20 " percent
" let g:netrw_browse_split = 4 " open files in previous window
let g:netrw_banner = 0
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

" ------------------------------------------------------------
" csv.vim
" ------------------------------------------------------------

" " Customize plugin mappings
" let g:no_csv_maps = 1
" if g:HasPlug('csv.vim')
"   if has('autocmd')
"     augroup csv_maps
"       autocmd!
"       au FileType csv nnoremap <buffer> <silent> <Leader>h :<C-U>call csv#MoveCol(-v:count1, line("."))<CR>
"       au FileType csv nnoremap <buffer> <silent> <Leader>l :<C-U>call csv#MoveCol(v:count1, line("."))<CR>
"       au FileType csv nnoremap <buffer> <silent> <Leader>k :<C-U>call csv#MoveCol(0, line(".")-v:count1)<CR>
"       au FileType csv nnoremap <buffer> <silent> <Leader>j :<C-U>call csv#MoveCol(0, line(".")+v:count1)<CR>
"       au FileType csv xnoremap <buffer> <silent> if :<C-U>call csv#MoveOver(0)<CR>
"       au FileType csv omap <buffer> <silent> if :norm vif<cr>
"       au FileType csv xnoremap <buffer> <silent> af :<C-U>call csv#MoveOver(1)<CR>
"       au FileType csv omap <buffer> <silent> af :norm vaf<cr>
"       au FileType csv xnoremap <buffer> <silent> iL :<C-U>call csv#SameFieldRegion()<CR>
"       au FileType csv omap <buffer> <silent> iL :<C-U>call csv#SameFieldRegion()<CR>
"     augroup end
"   endif
" endif

" ------------------------------------------------------------
" speeddating
" ------------------------------------------------------------

" see ~/.vim/after/plugin/speeddating.vim

" ------------------------------------------------------------
" axring.vim
" ------------------------------------------------------------

let g:axring_rings = [
      \ ['true', 'false'],
      \ ['verbose', 'debug', 'info', 'warn', 'error', 'fatal'],
      \ ]

" ------------------------------------------------------------
" coc.nvim
" ------------------------------------------------------------

if g:HasPlug('coc.nvim')
  set encoding=utf-8

  " Some servers have issues with backup files, see #649.
  set nobackup
  set nowritebackup

  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
  " delays and poor user experience.
  set updatetime=300

  " Don't pass messages to |ins-completion-menu|.
  set shortmess+=c

  " Disable startup warning if vim version < 8.1.1719.
  let g:coc_disable_startup_warning = 1

  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved.
  if has("nvim-0.5.0") || has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
  else
    set signcolumn=yes
  endif

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gR <Plug>(coc-references)

  " Apply AutoFix to problem on the current line.
  nmap <leader>qf  <Plug>(coc-fix-current)

  call coc#config('coc.source.around.firstMatch', 0)
  call coc#config('coc.source.buffer.firstMatch', 0)

  inoremap <silent> <C-x><C-f> <C-R>=coc#start({'source': 'file'})<CR>
  inoremap <silent> <C-x><C-]> <C-R>=coc#start({'source': 'tag'})<CR>
endif

" ------------------------------------------------------------
" Waikiki --- Minimal set of wiki feature.
" ------------------------------------------------------------

com! WikiIndex edit ~/notes/index.md

let g:waikiki_roots = ['~/notes']
let g:waikiki_default_maps = 0

" Use dashes in place of spaces in filenames.
let g:waikiki_space_replacement = '-'

" Expand the word under cursor with `g:waikiki_word_regex` instead of simple
" <cword> when creating new pages.
let g:waikiki_use_word_regex = 1
let g:waikiki_word_regex = '\(\.\?[-+0-9A-Za-z_]\+\)\+'

" Custom waikiki mappings.
func! SetupWaikiki() abort
  nmap <buffer> zl <Plug>(waikikiFollowLink)
  vmap <buffer> zl <Plug>(waikikiFollowLink)
  nmap <buffer> <C-w>zl <Plug>(waikikiFollowLinkSplit)
  vmap <buffer> <C-w>zl <Plug>(waikikiFollowLinkSplit)
  nmap <buffer> zh <Plug>(waikikiGoUp)

  nmap <buffer> <LocalLeader>l <Plug>(waikikiNextLink)
  nmap <buffer> <LocalLeader>L <Plug>(waikikiPrevLink)

  nmap <buffer> <LocalLeader>x <Plug>(waikikiToggleListItem)

  " Generate/refresh tags.
  nmap <buffer> <LocalLeader>t <Plug>(waikikiTags)
  " Tips:
  " - `g]` lists references of the tag under cursor.
  " - With 'junegunn/fzf.vim' installed, search for tags with `:Tags`.
  "   Otherwise use the builtin `:tags`.
  " - `<C-x><C-]>` completes tags.
  " - With 'coc-tag' installed, fuzzy completion will also match tags.

  " Conceal/prettify markup characters.
  setlocal conceallevel=2

  set suffixesadd+=.md
endfunc

if has('autocmd')
  augroup Waikiki  " Do NOT change! Group name defined by vim-waikiki.
    autocmd!
    autocmd User setup call SetupWaikiki()
  augroup end
endif

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
