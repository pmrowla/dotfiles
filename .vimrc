" .vimrc
" Author: Peter Rowlands <peter@pmrowla.com>

set nocompatible    " be iMproved

" set this before loading bundles so solarized works properly
set bg=dark

" vundle stuff goes in its own file
" See the vundle FAQ for explanation of why
source ~/.vim/bundles.vim

if has("autocmd")
    filetype plugin indent on   " required!
endif

if &t_Co > 2 || has("gui_running")
    set hlsearch
endif

" Colorscheme
colorscheme solarized

" Section: Options {{{1
" ---------------------

set autoindent
set autowrite       " auto save before commands like :next
set backspace=indent,eol,start  " make backspace work properly
set backupdir=/tmp,/var/tmp,~/tmp   " put backup files somewhere else
set cmdheight=2
set complete-=i     " don't search includes
set directory=/tmp,/var/tmp,~/tmp   " directory for swap files
set display=lastline

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

set fileformats=unix,dos,mac

" c: auto-wrap comments
" q: rewrap comments w/gq
" r: auto insert comment leader
" l: dont break existing long lines
set formatoptions=cqrl

set ignorecase      " case insensitive search
set modeline
set modelines=5
set noerrorbells    " bells are annoying
set number          " always show line numbers
set pastetoggle=<F2>
set ruler
set showcmd
set showmatch       " jump to matching brackets
set smartcase       " smart case insensitive search
set smarttab
set statusline=[%n]\ %<%.99f\ %h%w%m%r%{SL('CapsLockStatusline')}%y%{SL('fugitive#statusline')}%#ErrorMsg#%{SL('SyntasticStatuslineFlag')}%*%=%-14.(%l,%c%V%)\ %P
set textwidth=79    " anything bigger than this is annoying - see also: pep8
set undodir=/tmp,/var/tmp,~/tmp     " directory for undo tree files
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.pyc

if has("mouse")
    set mouse=a
endif

" Tabs
set expandtab       " expand tabs into spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Plugin Settings {{{2

let g:flake8_builtins="_,apply"
let g:netrw_list_hide = '^\.,^tags$,.*\.pyc$'
let g:python_highlight_all=1    " best settings for python.vim

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%/.git ls-files -oc --exclude-standard']
let g:gist_detect_filetype = 1
let g:gist_show_privates = 1
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
let g:NERDShutUp = 1
let g:NERDTreeHijackNetrw = 0
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 1

function! s:try(cmd, default)
    if exists(':' . a:cmd) && !v:count
        let tick = b:changedtick
        exe a:cmd
        if tick == b:changedtick
            execute 'normal! '.a:default
        endif
    else
        execute 'normal! '.v:count.a:default
    endif
endfunction

" }}}2

" }}}1

let g:c_syntax_for_h="true"     " c++ is dumb

" autocmds
if has("autocmd") && !exists("autocmds_loaded")
    " do this once
    let autocmds_loaded = 1

    " assume c/c++ always uses doxygen
    autocmd FileType c let b:comment = '\/\/'
    autocmd FileType c set ft=c.doxygen
    autocmd FileType cpp set ft=cpp.doxygen
    autocmd FileType h set ft=cpp.doxygen
    " autocmd FileType svn-base set ft=svnbase
    au BufNewFile,BufRead *.dxy setf doxygen
    autocmd BufWritePost *.py call Flake8()
endif

" Section: Commands {{{1
" ----------------------

if has("eval")

function! SL(function)
    if exists('*'.a:function)
        return call(a:function,[])
    else
        return ''
    endif
endfunction

endif   " has("eval")

" }}}1

" Section: Mappings {{{1
" ----------------------

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

map <F1>    <Esc>
map! <F1>   <Esc>
map <F2>    <nop>
map! <F2>    <nop>
map <F3>    :cnext<CR>
map <F4>    :cc<CR>
map <F5>    :cprev<CR>

noremap <S-Insert>  <MiddleMouse>
noremap! <S-Insert> <MiddleMouse>

" open files with path relative to current buffer
map <Leader>re :e <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>rt :tabnew <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>rv :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>rs :sp <C-R>=expand("%:p:h") . "/" <CR>

" }}}1

if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

" vim:set ft=vim et sw=4
