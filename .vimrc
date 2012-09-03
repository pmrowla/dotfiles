set nocompatible

if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

set bg=dark
colorscheme torte
set backspace=indent,eol,start
set ic
set ruler
set showcmd
set number
set tw=79

if has("mouse")
    set mouse=a
endif

set ignorecase
set smartcase

" Tabs
set expandtab
set ts=4
set sts=4
set sw=4
set smarttab

set autoindent
" C indenting
set cinwords=if,else,while,do,for,switch
set cindent
set cinoptions=>s,e0,n0,f0,{0,}0,^0,:0,=s,ps,t0,c3,+s,(2s,us,)20,*30,gs,hs

let python_highlight_all=1

" c: wrap comments
" q: rewrap comments w/gq
" r: auto insert comment char
" l: dont break existing long lines
set formatoptions=cqrl

filetype indent plugin on
let g:c_syntax_for_h="true"

" autocmd
if has("autocmd") && !exists("autocmds_loaded")
    " do this once
    let autocmds_loaded = 1

    autocmd FileType c let b:comment = '\/\/'
    autocmd FileType c set ft=c.doxygen
    autocmd FileType h set ft=c.doxygen
    " autocmd FileType svn-base set ft=svnbase
    au BufNewFile,BufRead *.dxy setf doxygen
endif

noremap <Up>    10k
noremap <Down>  10j
