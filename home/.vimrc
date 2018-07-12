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
if has('win32') || has('win64')
    set backupdir=~/AppData/Local/Temp  " put backup files somewhere else
    set directory=~/AppData/Local/Temp  " directory for swap files
else
    set backupdir=/tmp,/var/tmp,~/tmp   " put backup files somewhere else
    set directory=/tmp,/var/tmp,~/tmp   " directory for swap files
endif
set cmdheight=2
set complete-=i     " don't search includes
set display=lastline

set backupskip=/tmp/*,/private/tmp/*

if &encoding ==# 'latin1' && has('gui_running')
    set encoding=utf-8
endif

set fileformats=unix,dos,mac
set fileencodings=ucs-bom,utf-8,latin1,cp932,euc-jp,default

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
set undofile
set wildignore+=*.pyc

if has("mouse")
    set mouse=a
endif

" Tabs
set expandtab       " expand tabs into spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Plugin Settings {{{2

let g:netrw_list_hide = '^\.,^tags$,.*\.pyc$'
let g:python_highlight_all=1    " best settings for python.vim

let g:ctrlp_user_command = {
    \ 'types': {
    \   1: ['.git', 'git --git-dir=%s/.git ls-files -oc --exclude-standard'],
    \ },
\ }

let g:gist_detect_filetype = 1
let g:gist_show_privates = 1

let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_c_config_file = '.clang_complete'
let g:syntastic_cpp_config_file = '.clang_complete'
let g:syntastic_python_flake8_exec = 'python'
let g:syntastic_python_flake8_args = ['-m', 'flake8']

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
if has("autocmd")
    " solarized dark colors for vim-indent-guides
    let g:indent_guides_auto_colors = 0
    au VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=8 guibg=#002b36
    au VimEnter,ColorScheme * :hi IndentGuidesEven  ctermbg=0 guibg=#073642
endif

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

let g:filetype_inc="sourcepawn"

" autocmds
if has("autocmd") && !exists("autocmds_loaded")
    " do this once
    let autocmds_loaded = 1

    " assume c/c++ always uses doxygen
    autocmd FileType c let b:comment = '\/\/'
    autocmd FileType c set ft=c.doxygen
    autocmd FileType cpp set ft=cpp.doxygen
    autocmd FileType h set ft=cpp.doxygen
    autocmd BufNewFile,BufRead *.dxy setf doxygen
    autocmd BufNewFile,BufRead *.sls setf yaml
    autocmd BufNewFile,BufRead *.html setf htmljinja
    autocmd FileType yaml,json,toml set ts=2 sts=2 sw=2
    autocmd FileType javascript,html,django,htmldjango,jinja,htmljinja set ts=2 sts=2 sw=2 tw=0 wrap lbr

    " run flake8 on writes to a Python file
    autocmd BufWritePost *.py call Flake8()

    "autocmd FileType svn-base set ft=svnbase

    " only use relative numebering in the current buffer
    autocmd BufEnter * setlocal relativenumber number
    autocmd BufLeave * setlocal number
    " absolute numbers in insert mode
    "au InsertEnter * set number
    "au InsertLeave * set relativenumber

    " use wrap + linebreak for text based document types
    autocmd FileType latex,markdown,rst set tw=0 wrap lbr

    " assume kirikiri scripts are windows+jp only
    autocmd FileType kirikiri set tw=56 " max adv line length
    autocmd BufNewFile,BufRead *.ks set filetype=kirikiri
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

map <F8>    :TagbarToggle<CR>

noremap <S-Insert>  <MiddleMouse>
noremap! <S-Insert> <MiddleMouse>

" open files with path relative to current buffer
map <Leader>re :e <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>rt :tabnew <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>rv :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>rs :sp <C-R>=expand("%:p:h") . "/" <CR>

" encoding
nmap <silent> eu :set fenc=utf-8<CR>
nmap <silent> ee :set fenc=euc-jp<CR>
nmap <silent> es :set fenc=cp932<CR>

" encode reopen encoding
nmap <silent> eru :e ++enc=utf-8 %<CR>
nmap <silent> ere :e ++enc=euc-jp %<CR>
nmap <silent> ers :e ++enc=cp932 %<CR>
nmap <silent> erw :e ++enc=utf-16le %<CR>

" }}}1
"
" Section: Visual {{{1
" --------------------
if (&t_Co > 2 || has("gui_running")) && has("syntax")
    if exists("&guifont")
        if has("mac")
            set guifont=Menlo:h11
        elseif has("unix")
            if &guifont == ""
                set guifont=bitstream\ vera\ sans\ mono\ 10
            endif
        elseif has("win32") || has("win64")
            set guifont=Consolas:h9,Courier\ New:h9
        endif
    endif
endif
" }}}1

if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

" vim:set ft=vim et sw=4
