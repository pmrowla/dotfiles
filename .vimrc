" .vimrc
" Author: Peter Rowlands <peter@pmrowla.com>

set nocompatible    " be iMproved

" vundle stuff goes in its own file
" See the vundle FAQ for explanation of why
source ~/.vim/bundles.vim

if has("autocmd")
    filetype plugin indent on   " required!
endif

"
" A lot of stuff isn't set in this file because my bundle's use tpope's
" vim-sensible
"

if &t_Co > 2 || has("gui_running")
    set hlsearch
endif

" Colorscheme
set bg=dark
colorscheme torte

set ignorecase      " case insensitive search
set smartcase       " smart case insensitive search
set number          " always show line numbers
set textwidth=79    " anything bigger than this is annoying - see also: pep8
set encoding=utf-8  " use utf-8 not latin1
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.pyc
set noerrorbells    " bells are annoying
set backupdir=/tmp,/var/tmp,~/tmp   " put backup files somewhere else
set directory=/tmp,/var/tmp,~/tmp   " directory for swap files
set undodir=/tmp,/var/tmp,~/tmp     " directory for undo tree files

if has("mouse")
    set mouse=a
endif


" Tabs
set expandtab       " expand tabs into spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4

let python_highlight_all=1      " best settings for python.vim

let g:netrw_list_hide = '.*\.pyc$'

let g:gist_detect_filetype = 1
let g:gist_show_privates = 1

" c: wrap comments
" q: rewrap comments w/gq
" r: auto insert comment char
" l: dont break existing long lines
set formatoptions=cqrl

let g:c_syntax_for_h="true"     " c++ is dumb

" autocmds
if has("autocmd") && !exists("autocmds_loaded")
    " do this once
    let autocmds_loaded = 1

    " assume c/c++ always uses doxygen
    autocmd FileType c let b:comment = '\/\/'
    autocmd FileType c set ft=c.doxygen
    autocmd FileType h set ft=c.doxygen
    " autocmd FileType svn-base set ft=svnbase
    au BufNewFile,BufRead *.dxy setf doxygen
endif

" arrow keys are lazy ^U/^D
noremap <Up>    10k
noremap <Down>  10j

" fix numpad in some terminals
map <C-[>Op 0
map <C-[>Oq 1
map <C-[>Or 2
map <C-[>Os 3
map <C-[>Ot 4
map <C-[>Ou 5
map <C-[>Ov 6
map <C-[>Ow 7
map <C-[>Ox 8
map <C-[>Oy 9
map <C-[>OX =

" open files with path relative to current buffer
map <Leader>re :e <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>rt :tabnew <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>rv :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>rs :sp <C-R>=expand("%:p:h") . "/" <CR>

" vim:set ft=vim et sw=4
